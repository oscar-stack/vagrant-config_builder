# @see http://docs.vagrantup.com/v2/vagrantfile/machine_settings.html
class ConfigBuilder::Model::VM

  # @!attribute [rw] provider
  #   @return [ConfigBuilder::Model::Provider] The provider configuration for
  #     this VM
  attr_accessor :provider

  # @!attribute [rw] provisioners
  #   @return [Array<ConfigBuilder::Model::Provisioner>] A list of provisioner
  #     configurations for this VM
  attr_accessor :provisioners

  # @!attribute [rw] forwarded_ports
  #   @return [Array<ConfigBuilder::Model::Network::ForwardedPort>]
  attr_accessor :forwarded_ports

  # @!attribute [rw] private_networks
  #   @return [Array<ConfigBuilder::Model::Network::PrivateNetwork>]
  attr_accessor :private_networks

  # @!attribute [rw] synced_folders
  #   @return [Array<ConfigBuilder::Model::SyncedFolder>]
  attr_accessor :synced_folders
end
