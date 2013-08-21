# @see http://docs.vagrantup.com/v2/provisioning/puppet_agent.html
class ConfigBuilder::Model::Provisioner::PuppetServer < ConfigBuilder::Model::Base

  # @!attribute [rw] puppet_server
  #   @return [String]
  attr_accessor :puppet_server

  # @!attribute [rw] node_name
  #   @return [String]
  attr_accessor :node_name

  # @!attribute [rw] options
  #   @return [String]
  attr_accessor :options

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :puppet_server do |puppet_config|
        puppet_config.puppet_server = attr(:puppet_server)  if attr(:puppet_server)
        puppet_config.node_name     = attr(:node_name)      if attr(:node_name)
        puppet_config.options       = attr(:options)        if attr(:options)
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('puppet_server', self)
end
