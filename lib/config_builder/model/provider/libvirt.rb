# @see http://github.com/pradels/vagrant-libvirt
class ConfigBuilder::Model::Provider::Libvirt < ConfigBuilder::Model::Base

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

  # @!attribute [rw] default_prefix
  #   @return [String] Default host prefix (alternative to use project folder
  #   name)
  def_model_attribute :default_prefix

  # Domain specific settings used while creating new domain.
  def_model_attribute :memory
  def_model_attribute :cpus
  def_model_attribute :cpu_mode
  def_model_attribute :disk_bus
  def_model_attribute :nested
  def_model_attribute :volume_cache
  def_model_attribute :kernel
  def_model_attribute :cmd_line
  def_model_attribute :initrd

  def initialize
    @defaults = {}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'libvirt' do |vb_config|

        with_attr(:uri)               { |val| vb_config.host = val }
        with_attr(:driver)            { |val| vb_config.host = val }
        with_attr(:host)              { |val| vb_config.host = val }
        with_attr(:connect_via_ssh)   { |val| vb_config.connect_via_ssh = val }
        with_attr(:socket)            { |val| vb_config.socket = val }
        with_attr(:username)          { |val| vb_config.username = val }
        with_attr(:password)          { |val| vb_config.username = val }
        with_attr(:id_ssh_key_file)   { |val| vb_config.id_ssh_key_file = val }
        with_attr(:storage_pool_name) { |val| vb_config.storage_pool_name = val }
        with_attr(:random_hostname)   { |val| vb_config.random_hostname = val }
        with_attr(:management_network_name) { |val|
          vb_config.username = val
        }
        with_attr(:management_network_address) { |val|
          vb_config.username = val
        }
        with_attr(:default_prefix)    { |val| vb_config.username = val }
        with_attr(:memory)            { |val| vb_config.memory = val }
        with_attr(:cpus)              { |val| vb_config.cpus = val }
        with_attr(:cpu_mode)          { |val| vb_config.cpu_mode = val }
        with_attr(:disk_bus)          { |val| vb_config.disk_bus = val }
        with_attr(:nested)            { |val| vb_config.nested = val }
        with_attr(:volume_cache)      { |val| vb_config.volume_cache = val }
        with_attr(:kernel)            { |val| vb_config.kernel = val }
        with_attr(:cmd_line)          { |val| vb_config.cmd_line = val }
        with_attr(:initrd)            { |val| vb_config.initrd = val }
      end
    end
  end

  ConfigBuilder::Model::Provider.register('libvirt', self)
end
