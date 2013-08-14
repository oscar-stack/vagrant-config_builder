# @see http://docs.vagrantup.com/v2/vagrantfile/machine_settings.html
class ConfigBuilder::Model::VM < ConfigBuilder::Model::Base

  include ConfigBuilder::ModelDelegator

  # @!attribute [rw] provider
  #   @return [Hash<Symbol, Object>] The provider configuration for
  #     this VM
  #   @example
  #     >> vm.provider
  #     => {
  #           :type => 'virtualbox',
  #           :name => 'tiny-tina',
  #           :gui  => false,
  #        }
  def_model_delegator :provider

  # @!attribute [rw] provisioners
  #   @return [Array<Hash<Symbol, Object>>] A collection of provisioner
  #     parameters in the order that they should be applied
  #     of provisioner types, and a list of provisioner instances for each type
  #   @example
  #     >> vm.provisioners
  #     => [
  #           {:type => :shell, :path   => '/vagrant/bin/magic.sh'},
  #           {:type => :shell, :inline => '/bin/echo hello world'},
  #
  #           {:type => :puppet, :manifest => 'foo.pp'},
  #           {:type => :puppet, :manifest => 'bar.pp', :modulepath => '/vagrant/modules'},
  #        ]
  def_model_delegator :provisioners

  # @!attribute [rw] forwarded_ports
  #   @return [Array<Hash<Symbol, Object>>] A collection of port mappings
  #   @example
  #     >> vm.forwarded_ports
  #     => [
  #           {:guest => 80, :host  => 20080},
  #           {:guest => 443, :host => 20443},
  #        ]
  def_model_delegator :forwarded_ports

  # @!attribute [rw] private_networks
  #   @return [Array<Hash<Symbol, Object>>] A collection of IP address network
  #     settings.
  #   @example
  #     >> vm.private_networks
  #     => [
  #           {:ip => '10.20.4.1'},
  #           {:ip => '192.168.100.5', :netmask => '255.255.255.128'},
  #        ]
  def_model_delegator :private_networks

  # @!attribute [rw] synced_folders
  #   @return [Array<Hash<Symbol, Object>>]
  #   @example
  #     >> vm.synced_folders
  #     => [
  #           {:host_path => 'manifests/', :guest_path => '/root/manifests', :disabled => false},
  #           {:host_path => 'modules/', :guest_path => '/root/modules'},
  #        ]
  #
  def_model_delegator :synced_folders

  # @!attribute [rw] box
  #   @return [String] The name of the Vagrant box to instantiate for this VM
  def_model_attribute :box

  # @!attribute [rw] name
  #   @return [String] The name of the instantiated box in this environment
  def_model_attribute :name

  # @!attribute [rw] hostname
  #   @return [String] The hostname the machine should have.
  def_model_attribute :hostname

  def initialize
    @defaults = {
      :provisioners     => [],
      :forwarded_ports  => [],
      :private_networks => [],
      :synced_folders   => [],
    }
  end

  def to_proc
    Proc.new do |global_config|
      global_config.vm.define(attr(:name)) do |config|
        vm_config = config.vm

        vm_config.box = attr(:box) if defined? attr(:box)
        vm_config.hostname = attr(:hostname) if defined? attr(:hostname)

        eval_models(vm_config)
      end
    end
  end

  private

  def eval_provisioners(vm_config)
    attr(:provisioners).each do |hash|
      p = ConfigBuilder::Model::Provisioner.new_from_hash(hash)
      p.call(vm_config)
    end
  end

  def eval_provider(vm_config)
    if attr(:provider)
      p = ConfigBuilder::Model::Provider.new_from_hash(attr(:provider))
      p.call(vm_config)
    end
  end

  def eval_private_networks(vm_config)
    attr(:private_networks).each do |hash|
      n = ConfigBuilder::Model::Network::PrivateNetwork.new_from_hash(hash)
      n.call(vm_config)
    end
  end

  def eval_forwarded_ports(vm_config)
    attr(:forwarded_ports).each do |hash|
      f = ConfigBuilder::Model::Network::ForwardedPort.new_from_hash(hash)
      f.call(vm_config)
    end
  end

  def eval_synced_folders(vm_config)
    attr(:synced_folders).each do |hash|
      f = ConfigBuilder::Model::SyncedFolder.new_from_hash(hash)
      f.call(vm_config)
    end
  end
end
