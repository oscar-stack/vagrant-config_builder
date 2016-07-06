# @see https://github.com/devopsgroup-io/vagrant-digitalocean
class ConfigBuilder::Model::Provider::DigitalOcean < ConfigBuilder::Model::Provider::Base

  # Credentials
  def_model_attribute :token

  # Drolet Configuration
  def_model_attribute :image
  def_model_attribute :ipv6
  def_model_attribute :region
  def_model_attribute :size
  def_model_attribute :private_networking
  def_model_attribute :backups_enabled
  def_model_attribute :ssh_key_name
  def_model_attribute :setup

  def instance_id
    'digital_ocean'
  end

  ConfigBuilder::Model::Provider.register('digital_ocean', self)
end
