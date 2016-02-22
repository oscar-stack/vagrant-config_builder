# @see https://github.com/MSOpenTech/vagrant-azure
class ConfigBuilder::Model::Provider::Azure < ConfigBuilder::Model::Provider::Base

  def_model_attribute :mgmt_certificate
  def_model_attribute :mgmt_endpoint
  def_model_attribute :subscription_id
  def_model_attribute :storage_acct_name
  def_model_attribute :storage_access_key

  def_model_attribute :vm_name
  def_model_attribute :vm_user
  def_model_attribute :vm_password
  def_model_attribute :vm_image
  def_model_attribute :vm_location
  def_model_attribute :vm_affinity_group
  def_model_attribute :vm_virtual_network_name

  def_model_attribute :cloud_service_name
  def_model_attribute :deployment_name
  def_model_attribute :tcp_endpoints

  # ssh_private_key and ssh_certificate_file is overly specific and probably should be deprecated in favor of
  # private_key_file and certificate_file as they are in Azure ruby sdk.
  # This is here to not break compatibility with previous versions.
  def_model_attribute :private_key_file
  def_model_attribute :ssh_private_key_file
  def_model_attribute :certificate_file
  def_model_attribute :ssh_certificate_file

  def_model_attribute :ssh_port
  def_model_attribute :vm_size
  def_model_attribute :winrm_transport
  def_model_attribute :winrm_http_port
  def_model_attribute :winrm_https_port
  def_model_attribute :availability_set_name

  def_model_attribute :state_read_timeout

  def instance_id
    'azure'
  end

  ConfigBuilder::Model::Provider.register('azure', self)
end
