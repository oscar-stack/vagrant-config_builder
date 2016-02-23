# @see http://docs.vagrantup.com/v2/provisioning/puppet_agent.html
class ConfigBuilder::Model::Provisioner::PuppetServer < ConfigBuilder::Model::Provisioner::Base

  # @!attribute [rw] binary_path
  #   @return [String]
  def_model_attribute :binary_path

  # @!attribute [rw] client_cert_path
  #   @return [String]
  def_model_attribute :client_cert_path

  # @!attribute [rw] client_private_key_path
  #   @return [String]
  def_model_attribute :client_private_key_path

  # @!attribute [rw] facter
  #   @return [Hash]
  def_model_attribute :facter

  # @!attribute [rw] puppet_server
  #   @return [String]
  def_model_attribute :puppet_server

  # @!attribute [rw] puppet_node
  #   @return [String]
  def_model_attribute :puppet_node

  # @!attribute [rw] options
  #   @return [String]
  def_model_attribute :options

  ConfigBuilder::Model::Provisioner.register('puppet_server', self)
end
