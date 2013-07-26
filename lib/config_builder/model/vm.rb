# @see http://docs.vagrantup.com/v2/vagrantfile/machine_settings.html
class ConfigBuilder::Model::VM < ConfigBuilder::Model::Base

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
  attr_accessor :provider

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
  attr_accessor :provisioners

  # @!attribute [rw] forwarded_ports
  #   @return [Array<Hash<Symbol, Object>>] A collection of port mappings
  #   @example
  #     >> vm.forwarded_ports
  #     => [
  #           {:guest => 80, :host  => 20080},
  #           {:guest => 443, :host => 20443},
  #        ]
  attr_accessor :forwarded_ports

  # @!attribute [rw] private_networks
  #   @return [Array<Hash<Symbol, Object>>] A collection of IP address network
  #     settings.
  #   @example
  #     >> vm.private_networks
  #     => [
  #           {:ip => '10.20.4.1'},
  #           {:ip => '192.168.100.5', :netmask => '255.255.255.128'},
  #        ]
  attr_accessor :private_networks

  # @!attribute [rw] synced_folders
  #   @return [Array<Hash<Symbol, Object>>]
  #   @example
  #     >> vm.synced_folders
  #     => [
  #           {:host_path => 'manifests/', :guest_path => '/root/manifests', :disabled => false},
  #           {:host_path => 'modules/', :guest_path => '/root/modules'},
  #        ]
  #
  attr_accessor :synced_folders

  # @!attribute [rw] box
  #   @return [String] The name of the Vagrant box to instantiate for this VM
  attr_accessor :box

  # @!attribute [rw] name
  #   @return [String] The name of the instantiated box in this environment
  attr_accessor :name

  def initialize
    @provisioners     = []
    @forwarded_ports  = []
    @private_networks = []
    @synced_folders   = []
  end

  def to_proc
    Proc.new do |global_config|
      global_config.vm.define @name do |config|
        vm_config = config

        eval_provider(vm_config)
        eval_provisioners(vm_config)
        eval_box(vm_config)
        eval_private_networks(vm_config)
        eval_forwarded_ports(vm_config)
        eval_synced_folders(vm_config)

        @extensions.each { |ext| send("eval_#{ext}".intern, vm_config) }
      end
    end
  end

  def eval_provisioners(vm_config)
    @provisioners.each do |hash|
      p = ConfigBuilder::ModelCollection.provisioner.generate(hash)
      p.call(vm_config)
    end
  end

  def eval_provider(vm_config)
    if defined? @provider
      p = ConfigBuilder::ModelCollection.provider.generate(@provider)
      p.call(vm_config)
    end
  end

  def eval_box(vm_config)
    vm_config.box = @box if defined? @box
  end

  def eval_private_networks(vm_config)
    @private_networks.each do |hash|
      n = ConfigBuilder::Model::Network::PrivateNetwork.new_from_hash(hash)
      n.call(vm_config)
    end
  end

  def eval_forwarded_ports(vm_config)
    @forwarded_ports.each do |hash|
      f = ConfigBuilder::Model::Network::ForwardedPort.new_from_hash(hash)
      f.call(vm_config)
    end
  end

  def eval_synced_folders(vm_config)
    @synced_folders.each do |hash|
      f = ConfigBuilder::Model::SyncedFolder.new_from_hash(hash)
      f.call(vm_config)
    end
  end
end
