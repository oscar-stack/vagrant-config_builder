# @see http://docs.vagrantup.com/v2/vagrantfile/machine_settings.html
class ConfigBuilder::Model::VM

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
end
