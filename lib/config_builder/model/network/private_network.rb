# Vagrant private network
#
# @see http://docs.vagrantup.com/v2/networking/private_network.html
class ConfigBuilder::Model::Network::PrivateNetwork < ConfigBuilder::Model::Base

  # @!attribute [rw] :ip
  #   @return [String] The IP address to use for the private network interface
  def_model_attribute :ip

  def to_proc
    Proc.new do |vm_config|
      vm_config.network(:private_network, @attrs)
    end
  end
end
