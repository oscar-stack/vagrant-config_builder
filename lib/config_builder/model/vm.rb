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
  #
  #   @deprecated Use {#providers} instead.
  def_model_delegator :provider

  # @!attribute [rw] providers
  #   @return [Array<Hash{String, Symbol => Object}>] A collection of provider
  #     parameters that should be applied to a VM.
  #   @example
  #     >> vm.providers
  #     => [
  #          {:type => 'virtualbox', :customize => ['modifyvm', :id, '--memory', 1024]},
  #          {:type => 'vmware_fusion', :vmx => {:memsize => 1024}},
  #        ]
  def_model_delegator :providers

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

  # @!attribute [rw] guest
  #   @return [String] The guest type to use for this VM
  def_model_attribute :guest

  # @!attribute [rw] box
  #   @return [String] This configures what box the machine will be brought up
  #     against. The value here should be the name of an installed box or a
  #     shorthand name of a box in Vagrant Cloud.
  def_model_attribute :box

  # @!attribute [rw] box_url
  #   @return [String, Array<String>] The URL that the configured box can be
  #     found at. If `box` is a shorthand to a box in Vagrant Cloud then this
  #     value doesn't need to be specified. Otherwise, it should point to the
  #     proper place where the box can be found if it isn't installed.
  #
  #     This can also be an array of multiple URLs. The URLs will be tried in
  #     order. Note that any client certificates, insecure download settings,
  #     and so on will apply to all URLs in this list.
  #
  #     The URLs can also be local files by using the file:// scheme. For
  #     example: "file:///tmp/test.box".
  def_model_attribute :box_url

  # @!attribute [rw] box_download_checksum
  #   @return [String] The checksum of the box specified by `box_url`.
  #     If not specified, no checksum comparison will be done. If specified,
  #     Vagrant will compare the checksum of the downloaded box to this value
  #     and error if they do not match. Checksum checking is only done when
  #     Vagrant must download the box.
  #
  #     If this is specified, then `box_download_checksum_type` must also be
  #     specified.
  def_model_attribute :box_download_checksum

  # @!attribute [rw] box_download_checksum_type
  #   @return [String] The type of checksum specified by
  #     `box_download_checksum` (if any). Supported values are currently `md5`,
  #     `sha1`, and `sha256`.
  def_model_attribute :box_download_checksum_type

  # @!attribute [rw] box_download_client_cert
  #   @return [String] Path to a client certificate to use when downloading the
  #     box, if it is necessary. By default, no client certificate is used to
  #     download the box.
  def_model_attribute :box_download_client_cert

  # @!attribute [rw] box_download_insecure
  #   @return [Boolean] If `true`, then SSL certificates from the server will
  #     not be verified. By default, if the URL is an HTTPS URL, then SSL certs
  #     will be verified.
  def_model_attribute :box_download_insecure

  # @!attribute [rw] box_check_update
  #   @return [Boolean] If true, Vagrant will check for updates to the
  #     configured box on every `vagrant up`. If an update is found, Vagrant
  #     will tell the user. By default this is `true`. Updates will only be
  #     checked for boxes that properly support updates (boxes from Vagrant
  #     Cloud or some other versioned box).
  def_model_attribute :box_check_update

  # @!attribute [rw] box_version
  #   @return [String] The version of the box to use. This defaults to ">= 0"
  #     (the latest version available). This can contain an arbitrary list of
  #     constraints, separated by commas, such as: >= 1.0, < 1.5. When
  #     constraints are given, Vagrant will use the latest available box
  #     satisfying these constraints.
  def_model_attribute :box_version

  # @!attribute [rw] name
  #   @return [String] The name of the instantiated box in this environment
  def_model_attribute :name

  # @!attribute [rw] hostname
  #   @return [String] The hostname the machine should have.
  def_model_attribute :hostname

  # @!attribute [rw] communicator
  #   @return [String] The name of the communicator to use when sending
  #   commands to this box. Set to 'winrm' for Windows VMs.
  def_model_attribute :communicator

  # @!attribute [rw] autostart
  #   @return [Boolean] If true, vagrant will start the box on "vagrant up".
  #   If false, vagrant must be given the box name explicitly or it will not
  #   start.
  def_model_attribute :autostart

  def initialize
    @defaults = {
      :providers        => [],
      :provisioners     => [],
      :forwarded_ports  => [],
      :private_networks => [],
      :synced_folders   => [],
      :autostart        => true,
    }
  end

  def to_proc
    Proc.new do |global_config|
      global_config.vm.define(attr(:name), autostart: attr(:autostart)) do |config|
        vm_config = config.vm

        with_attr(:box)                        { |val| vm_config.box = val }
        with_attr(:box_url)                    { |val| vm_config.box_url = val }
        with_attr(:box_download_checksum)      { |val| vm_config.box_download_checksum = val }
        with_attr(:box_download_checksum_type) { |val| vm_config.box_download_checksum_type = val }
        with_attr(:box_download_client_cert)   { |val| vm_config.box_download_client_cert = val }
        with_attr(:box_download_insecure)      { |val| vm_config.box_download_insecure = val }
        with_attr(:box_check_update)           { |val| vm_config.box_check_update = val }
        with_attr(:box_version)                { |val| vm_config.box_version = val }

        with_attr(:hostname) { |val| vm_config.hostname = attr(:hostname) }
        with_attr(:guest)    { |val| vm_config.guest    = attr(:guest)    }

        with_attr(:communicator) { |val| vm_config.communicator = attr(:communicator) }

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

  def eval_providers(vm_config)
    attr(:providers).each do |hash|
      p = ConfigBuilder::Model::Provider.new_from_hash(hash)
      p.call(vm_config)
    end
  end

  def eval_provider(vm_config)
    if attr(:provider)
      ConfigBuilder.logger.warn {
        I18n.t('config_builder.model.vm.provider_is_deprecated', :name => attr(:name))
      }

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
