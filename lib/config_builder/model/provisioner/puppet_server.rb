# @see http://docs.vagrantup.com/v2/provisioning/puppet_agent.html
class ConfigBuilder::Model::Provisioner::PuppetServer < ConfigBuilder::Model::Base

  # @!attribute [rw] binary_path
  #   @return [String]
  attr_accessor :binary_path

  # @!attribute [rw] client_cert_path
  #   @return [String]
  attr_accessor :client_cert_path

  # @!attribute [rw] client_private_key_path
  #   @return [String]
  attr_accessor :client_private_key_path
  
  # @!attribute [rw] facter
  #   @return [Hash]
  attr_accessor :facter

  # @!attribute [rw] puppet_server
  #   @return [String]
  attr_accessor :puppet_server

  # @!attribute [rw] puppet_node
  #   @return [String]
  attr_accessor :puppet_node

  # @!attribute [rw] options
  #   @return [String]
  attr_accessor :options

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :puppet_server do |puppet_config|
        with_attr(:binary_path)             { |val| puppet_config.binary_path             = val }
        with_attr(:client_cert_path)        { |val| puppet_config.client_cert_path        = val }
        with_attr(:client_private_key_path) { |val| puppet_config.client_private_key_path = val }
        with_attr(:facter)                  { |val| puppet_config.facter                  = val }
        with_attr(:puppet_server)           { |val| puppet_config.puppet_server           = val }
        with_attr(:puppet_node)             { |val| puppet_config.puppet_node             = val }
        with_attr(:options)                 { |val| puppet_config.options                 = val }
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('puppet_server', self)
end
