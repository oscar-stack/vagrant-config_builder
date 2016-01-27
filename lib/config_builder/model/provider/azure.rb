# @see https://github.com/MSOpenTech/vagrant-azure
class ConfigBuilder::Model::Provider::Azure < ConfigBuilder::Model::Base

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

  def initialize
    @defaults = {}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'azure' do |config|
        with_attr(:mgmt_certificate)        { |val| config.mgmt_certificate        = val }
        with_attr(:mgmt_endpoint)           { |val| config.mgmt_endpoint           = val }
        with_attr(:subscription_id)         { |val| config.subscription_id         = val }
        with_attr(:storage_acct_name)       { |val| config.storage_acct_name       = val }
        with_attr(:storage_access_key)      { |val| config.storage_access_key      = val }
        with_attr(:vm_name)                 { |val| config.vm_name                 = val }
        with_attr(:vm_user)                 { |val| config.vm_user                 = val }
        with_attr(:vm_password)             { |val| config.vm_password             = val }
        with_attr(:vm_image)                { |val| config.vm_image                = val }
        with_attr(:vm_location)             { |val| config.vm_location             = val }
        with_attr(:vm_affinity_group)       { |val| config.vm_affinity_group       = val }
        with_attr(:vm_virtual_network_name) { |val| config.vm_virtual_network_name = val }
        with_attr(:cloud_service_name)      { |val| config.cloud_service_name      = val }
        with_attr(:deployment_name)         { |val| config.deployment_name         = val }
        with_attr(:tcp_endpoints)           { |val| config.tcp_endpoints           = val }
        with_attr(:private_key_file)        { |val| config.private_key_file        = val }
        with_attr(:ssh_private_key_file)    { |val| config.ssh_private_key_file    = val }
        with_attr(:certificate_file)        { |val| config.certificate_file        = val }
        with_attr(:ssh_certificate_file)    { |val| config.ssh_certificate_file    = val }
        with_attr(:ssh_port)                { |val| config.ssh_port                = val }
        with_attr(:vm_size)                 { |val| config.vm_size                 = val }
        with_attr(:winrm_transport)         { |val| config.winrm_transport         = val }
        with_attr(:winrm_http_port)         { |val| config.winrm_http_port         = val }
        with_attr(:winrm_https_port)        { |val| config.winrm_https_port        = val }
        with_attr(:availability_set_name)   { |val| config.availability_set_name   = val }
        with_attr(:state_read_timeout)      { |val| config.state_read_timeout      = val }
      end
    end
  end

  ConfigBuilder::Model::Provider.register('azure', self)
end
