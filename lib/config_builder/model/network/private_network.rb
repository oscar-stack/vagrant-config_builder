# Vagrant private network
#
# @see http://docs.vagrantup.com/v2/networking/private_network.html
class ConfigBuilder::Model::Network::PrivateNetwork < ConfigBuilder::Model

  # @!attribute [rw] :ip
  #   @return [String] The IP address to use for the private network interface
  attr_accessor :ip

  def to_proc
    Proc.new do |config|
      config.network(:private_network, :ip => @ip)
    end
  end
end
