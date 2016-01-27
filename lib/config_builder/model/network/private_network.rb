# Vagrant private network
#
# @see http://docs.vagrantup.com/v2/networking/private_network.html
class ConfigBuilder::Model::Network::PrivateNetwork < ConfigBuilder::Model::Base

  # @!attribute [rw] :ip
  #   @return [String] The IP address to use for the private network interface.
  def_model_attribute :ip

  # @!attribute [rw] :netmask
  #   @return [String] The netmask to use for the private network interface.
  def_model_attribute :netmask

  # @!attribute [rw] :type
  #   @return [String]
  def_model_attribute :type

  # @!attribute [rw] :auto_config
  #   @return [Boolean]
  def_model_attribute :auto_config

  def to_proc
    Proc.new do |vm_config|
      vm_config.network(:private_network, private_network_opts)
    end
  end

  def private_network_opts
    h = {}
    with_attr(:ip)          { |val| h[:ip]          = val }
    with_attr(:netmask)     { |val| h[:netmask]     = val }
    with_attr(:type)        { |val| h[:type]        = val }
    with_attr(:auto_config) { |val| h[:auto_config] = val }
    h
  end
end
