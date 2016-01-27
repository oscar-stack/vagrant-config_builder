# Vagrant public network
#
# @see http://docs.vagrantup.com/v2/networking/public_network.html
class ConfigBuilder::Model::Network::PublicNetwork < ConfigBuilder::Model::Base

  # @!attribute [rw] :ip
  #   @return [String] The IP address to use for the public network interface.
  def_model_attribute :ip

  # @!attribute [rw] :bridge
  #   @return [String, Array<String>] If more than one network interface is
  #     available on the host machine, Vagrant will ask you to choose which interface
  #     the virtual machine should bridge to. A default interface can be specified by
  #     adding a :bridge clause to the network definition.
  def_model_attribute :bridge

  # @!attribute [rw] :use_dhcp_assigned_default_route
  #   @return [Boolean]
  def_model_attribute :use_dhcp_assigned_default_route

  # @!attribute [rw] :auto_config
  #   @return [Boolean]
  def_model_attribute :auto_config

  def to_proc
    Proc.new do |vm_config|
      vm_config.network(:public_network, public_network_opts)
    end
  end

  def public_network_opts
    h = {}
    with_attr(:ip)                              { |val| h[:ip]                              = val }
    with_attr(:use_dhcp_assigned_default_route) { |val| h[:use_dhcp_assigned_default_route] = val }
    with_attr(:bridge)                          { |val| h[:bridge]                          = val }
    with_attr(:auto_config)                     { |val| h[:auto_config]                     = val }
    h
  end
end
