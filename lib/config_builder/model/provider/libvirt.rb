# @see http://github.com/pradels/vagrant-libvirt
class ConfigBuilder::Model::Provider::Libvirt < ConfigBuilder::Model::Provider::Base

  # @!attribute [rw] uri
  #   @return [String] Manually specify URI
  def_model_attribute :uri

  # @!attribute [rw] driver
  #   @return [String] A hypervisor name to access via Libvirt.
  def_model_attribute :driver

  # @!attribute [rw] host
  #   @return [String] The name of the server, where libvirtd is running.
  def_model_attribute :host

  # @!attribute [rw] connect_via_ssh
  #   @return [String] If use ssh tunnel to connect to Libvirt.
  def_model_attribute :connect_via_ssh

  # @!attribute [rw] socket
  #   @return [String] Path towards the libvirt socket
  def_model_attribute :socket

  # @!attribute [rw] username
  #   @return [String] The username to access Libvirt.
  def_model_attribute :username

  # @!attribute [rw] password
  #   @return [String] Password for Libvirt connection.
  def_model_attribute :password

  # @!attribute [rw] id_ssh_key_file
  #   @return [String] ID SSH key file
  def_model_attribute :id_ssh_key_file

  # @!attribute [rw] storage_pool_name
  #   @return [String] Libvirt storage pool name, where box image and instance
  #   snapshots will be stored.
  def_model_attribute :storage_pool_name

  # @!attribute [rw] random_hostname
  #   @return [String] Turn on to prevent hostname conflicts
  def_model_attribute :random_hostname

  # @!attribute [rw] management_network_name
  #   @return [String] Libvirt default network name
  def_model_attribute :management_network_name

  # @!attribute [rw] management_network_address
  #   @return [String] Libvirt default network address
  def_model_attribute :management_network_address

  # @!attribute [rw] management_network_mode
  #   @return [String]
  def_model_attribute :management_network_mode

  # @!attribute [rw] management_network_mac
  #   @return [String]
  def_model_attribute :management_network_mac

  # @!attribute [rw] default_prefix
  #   @return [String] Default host prefix (alternative to use project folder
  #   name)
  def_model_attribute :default_prefix

  # Domain specific settings used while creating new domain.
  def_model_attribute :uuid
  def_model_attribute :memory
  def_model_attribute :cpus
  def_model_attribute :cpu_mode
  def_model_attribute :loader
  def_model_attribute :boot_order
  def_model_attribute :machine_type
  def_model_attribute :machine_arch
  def_model_attribute :machine_virtual_size
  def_model_attribute :disk_bus
  def_model_attribute :nic_model_type
  def_model_attribute :nested
  def_model_attribute :volume_cache
  def_model_attribute :kernel
  def_model_attribute :cmd_line
  def_model_attribute :initrd
  def_model_attribute :graphics_type
  def_model_attribute :graphics_autoport
  def_model_attribute :graphics_port
  def_model_attribute :graphics_passwd
  def_model_attribute :graphics_ip
  def_model_attribute :video_type
  def_model_attribute :video_vram
  def_model_attribute :keymap
  def_model_attribute :nic_adapter_count
  def_model_attribute :disks
  def_model_attribute :cdroms
  def_model_attribute :inputs
  def_model_attribute :suspend_mode

  def instance_id
    'libvirt'
  end

  ConfigBuilder::Model::Provider.register('libvirt', self)
end
