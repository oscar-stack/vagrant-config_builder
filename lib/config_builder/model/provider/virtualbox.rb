# @see http://docs.vagrantup.com/v2/virtualbox/configuration.html
class ConfigBuilder::Model::Provider::Virtualbox < ConfigBuilder::Model::Provider::Base

  # Vagrant by default will make "smart" decisions to enable/disable
  # the NAT DNS proxy. If this is set to `true`, then the DNS proxy
  # will not be enabled, and it is up to the end user to do it.
  #
  # @return [Boolean]
  def_model_attribute :auto_nat_dns_proxy

  # If true, will check if guest additions are installed and up to
  # date. By default, this is true.
  #
  # @return [Boolean]
  def_model_attribute :check_guest_additions

  # @!attribute [rw] customize
  #   @return [Array<String>] A list of customize arguments to use upon VM
  #   instantiation.
  def_model_attribute :customize

  # Shortcut for setting CPU count for the virtual machine.
  # Calls #customize internally.
  #
  # @param count [Integer, String] the count of CPUs
  def_model_attribute :cpus

  # If true, unused network interfaces will automatically be deleted.
  # This defaults to false because the detection does not work across
  # multiple users, and because on Windows this operation requires
  # administrative privileges.
  #
  # @return [Boolean]
  def_model_attribute :destroy_unused_network_interfaces

  # If set to `true`, then VirtualBox will be launched with a GUI.
  #
  # @return [Boolean]
  def_model_attribute :gui

  # If set to `true`, then a linked clone is created from a master
  # VM generated from the specified box.
  #
  # @return [Boolean]
  def_model_attribute :linked_clone

  # The snapshot to base the linked clone from. If this isn't set
  # a snapshot will be made with the name of "base" which will be used.
  #
  # If this is set, then the snapshot must already exist.
  #
  # @return [String]
  def_model_attribute :linked_clone_snapshot

  # Shortcut for setting memory size for the virtual machine.
  # Calls #customize internally.
  #
  # @param size [Integer, String] the memory size in MB
  def_model_attribute :memory

  # This should be set to the name of the machine in the VirtualBox
  # GUI.
  #
  # @return [String]
  def_model_attribute :name

  # Whether or not this VM has a functional vboxsf filesystem module.
  # This defaults to true. If you set this to false, then the "virtualbox"
  # synced folder type won't be valid.
  #
  # @return [Boolean]
  def_model_attribute :functional_vboxsf

  def initialize
    @defaults = {:customize => []}
  end

  def instance_id
    'virtualbox'
  end

  # @private
  def configure_customize(config, val)
    val.each do |cmd|
      config.customize(cmd)
    end
  end

  # @private
  def configure_linked_clone(config, val)
    # Linked clone support landed in Vagrant 1.8
    config.linked_clone = val if (Vagrant::VERSION > '1.8')
  end

  # @private
  def configure_linked_clone_snapshot(config, val)
    # Linked clone support landed in Vagrant 1.8
    config.linked_clone_snapshot = val if (Vagrant::VERSION > '1.8')
  end

  ConfigBuilder::Model::Provider.register('virtualbox', self)
end
