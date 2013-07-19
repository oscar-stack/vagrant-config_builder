require 'activemodel'

# Vagrant private network
#
# @see http://docs.vagrantup.com/v2/networking/private_network.html
class ConfigBuilder::Model::Network::PrivateNetwork

  # @!attribute [rw] :ip
  #   @return [String] The IP address to use for the private network interface
  attr_accessor :ip

end
