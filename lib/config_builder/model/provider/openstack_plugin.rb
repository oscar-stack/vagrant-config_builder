# @see https://github.com/cloudbau/vagrant-openstack-plugin
class ConfigBuilder::Model::Provider::OpenstackPlugin < ConfigBuilder::Model::Provider::Base

  def_model_attribute :username
  def_model_attribute :api_key
  def_model_attribute :tenant
  def_model_attribute :region
  def_model_attribute :endpoint
  def_model_attribute :proxy
  def_model_attribute :ssl_verify_peer

  def_model_attribute :server_name
  def_model_attribute :flavor
  def_model_attribute :image
  def_model_attribute :availability_zone
  def_model_attribute :security_groups
  def_model_attribute :user_data
  def_model_attribute :metadata
  def_model_attribute :scheduler_hints

  def_model_attribute :floating_ip
  def_model_attribute :floating_ip_pool

  def_model_attribute :network
  def_model_attribute :networks
  def_model_attribute :address_id

  def_model_attribute :disks

  def_model_attribute :orchestration_stack_name
  def_model_attribute :orchestration_stack_destroy
  def_model_attribute :orchestration_cfn_template
  def_model_attribute :orchestration_cfn_template_file
  def_model_attribute :orchestration_cfn_template_url
  def_model_attribute :orchestration_cfn_template_parameters

  def_model_attribute :keypair_name
  def_model_attribute :ssh_username
  def_model_attribute :ssh_ip_family

  def instance_id
    'openstack'
  end

  ConfigBuilder::Model::Provider.register('openstack_plugin', self)
end
