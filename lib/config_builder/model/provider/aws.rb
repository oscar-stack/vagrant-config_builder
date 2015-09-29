# Provider support for Vagrant-AWS
#
# @see https://github.com/mitchellh/vagrant-aws/blob/master/README.md#configuration
# @since 0.15.0
class ConfigBuilder::Model::Provider::Aws < ConfigBuilder::Model::Base

  def_model_attribute :access_key_id
  def_model_attribute :ami
  def_model_attribute :availability_zone
  def_model_attribute :instance_ready_timeout
  def_model_attribute :instance_check_interval
  def_model_attribute :instance_package_timeout
  def_model_attribute :instance_type
  def_model_attribute :keypair_name
  def_model_attribute :session_token
  def_model_attribute :private_ip_address
  def_model_attribute :elastic_ip
  def_model_attribute :region
  def_model_attribute :secret_access_key
  def_model_attribute :security_groups
  def_model_attribute :iam_instance_profile_arn
  def_model_attribute :subnet_id
  def_model_attribute :associate_public_ip
  def_model_attribute :ssh_host_attribute
  def_model_attribute :tags
  def_model_attribute :package_tags
  def_model_attribute :use_iam_profile
  def_model_attribute :block_device_mapping
  def_model_attribute :elb
  def_model_attribute :unregister_elb_from_az
  def_model_attribute :terminate_on_shutdown

  def initialize
    @defaults = {}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'aws' do |config|
        with_attr(:access_key_id)             { |val| config.access_key_id = val }
        with_attr(:ami)                       { |val| config.ami = val }
        with_attr(:availability_zone)         { |val| config.availability_zone = val }
        with_attr(:instance_ready_timeout)    { |val| config.instance_ready_timeout = val }
        with_attr(:instance_check_interval)   { |val| config.instance_check_interval = val }
        with_attr(:instance_package_timeout)  { |val| config.instance_package_timeout = val }
        with_attr(:instance_type)             { |val| config.instance_type = val }
        with_attr(:keypair_name)              { |val| config.keypair_name = val }
        with_attr(:session_token)             { |val| config.session_token = val }
        with_attr(:private_ip_address)        { |val| config.private_ip_address = val }
        with_attr(:elastic_ip)                { |val| config.elastic_ip = val }
        with_attr(:region)                    { |val| config.region = val }
        with_attr(:secret_access_key)         { |val| config.secret_access_key = val }
        with_attr(:security_groups)           { |val| config.security_groups = val }
        with_attr(:iam_instance_profile_arn)  { |val| config.iam_instance_profile_arn = val }
        with_attr(:subnet_id)                 { |val| config.subnet_id = val }
        with_attr(:associate_public_ip)       { |val| config.associate_public_ip = val }
        with_attr(:ssh_host_attribute)        { |val| config.ssh_host_attribute = val }
        with_attr(:tags)                      { |val| config.tags = val }
        with_attr(:package_tags)              { |val| config.package_tags = val }
        with_attr(:use_iam_profile)           { |val| config.use_iam_profile = val }
        with_attr(:block_device_mapping)      { |val| config.block_device_mapping = val }
        with_attr(:elb)                       { |val| config.elb = val }
        with_attr(:unregister_elb_from_az)    { |val| config.unregister_elb_from_az = val }
        with_attr(:terminate_on_shutdown)     { |val| config.terminate_on_shutdown = val }
      end
    end
  end

  ConfigBuilder::Model::Provider.register('aws', self)
end
