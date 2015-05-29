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

  # @!attribute [rw] run
  #   @return [String] Defaults to not set. If set to 'always' will cause provisioner to always run.
  attr_accessor :run

  def initialize
    @defaults = {
     :run => 'once',
    }
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :puppet_server, run: attr(:run) do |puppet_config|
        with_attr(:puppet_server) { |val| puppet_config.puppet_server = val }
        with_attr(:node_name)     { |val| puppet_config.node_name     = val }
        with_attr(:options)       { |val| puppet_config.options       = val }
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('puppet_server', self)
end
