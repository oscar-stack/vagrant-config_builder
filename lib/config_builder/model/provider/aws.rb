# Provider support for Vagrant-AWS
#
# @see https://github.com/mitchellh/vagrant-aws/blob/master/README.md#configuration
# @since 0.15.0
class ConfigBuilder::Model::Provider::Aws < ConfigBuilder::Model::Provider::Base

  def_model_attribute :access_key_id
  def_model_attribute :ami
  def_model_attribute :availability_zone
  def_model_attribute :instance_ready_timeout
  def_model_attribute :instance_check_interval
  def_model_attribute :instance_package_timeout
  def_model_attribute :instance_type
  def_model_attribute :keypair_name
  def_model_attribute :private_ip_address
  def_model_attribute :elastic_ip
  def_model_attribute :region
  def_model_attribute :endpoint
  def_model_attribute :version
  def_model_attribute :secret_access_key
  def_model_attribute :session_token
  def_model_attribute :security_groups
  def_model_attribute :iam_instance_profile_arn
  def_model_attribute :iam_instance_profile_name
  def_model_attribute :subnet_id
  def_model_attribute :tags
  def_model_attribute :package_tags
  def_model_attribute :use_iam_profile
  def_model_attribute :user_data
  def_model_attribute :block_device_mapping
  def_model_attribute :terminate_on_shutdown
  def_model_attribute :ssh_host_attribute
  def_model_attribute :monitoring
  def_model_attribute :elb_optimized
  def_model_attribute :source_dest_check
  def_model_attribute :associate_public_ip
  def_model_attribute :elb
  def_model_attribute :unregister_elb_from_az
  def_model_attribute :kernel_id
  def_model_attribute :tenancy

  def instance_id
    'aws'
  end

  ConfigBuilder::Model::Provider.register('aws', self)
end
