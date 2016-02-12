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
      # NOTE: @attrs _must_ be used here to preserve compatibility with the
      # vagrant-auto_network plugin.
      # FIXME: Re-factor attribute handling so that this sort of magic isn't
      # necessary.
      vm_config.network(:private_network, @attrs)
    end
  end
end
