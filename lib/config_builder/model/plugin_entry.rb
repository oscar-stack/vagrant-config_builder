# Vagrant shared folder model.
#
# @see http://docs.vagrantup.com/v2/plugins/index.html
class ConfigBuilder::Model::PluginEntry < ConfigBuilder::Model::Base

  # @!attribute [rw] plugin
  #   @return [String] The name of the Vagrant plugin to address
  def_model_attribute :plugin

  # @!attribute [rw] config_attribute
  #   @return [String] The name of the attribute to use for configuring the plugin
  def_model_attribute :config_attribute

  # @!attribute [rw] settings
  #   @return [Hash<Symbol, Object>] List with settings and their value for configuring the plugin 
  def_model_attribute :settings

  def to_proc
    Proc.new do |global_config|
      if Vagrant.has_plugin?(attr(:plugin)) then
        global_config.send(attr(:config_attribute), attr(:settings))
      end
    end
  end
end