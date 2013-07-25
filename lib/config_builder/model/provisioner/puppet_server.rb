# @see http://docs.vagrantup.com/v2/provisioning/puppet_agent.html
class ConfigBuilder::Model::Provisioner::PuppetServer

  # @!attribute [rw] puppet_server
  #   @return [String]
  attr_accessor :puppet_server

  # @!attribute [rw] node_name
  #   @return [String]
  attr_accessor :node_name

  # @!attribute [rw] options
  #   @return [String]
  attr_accessor :options
end
