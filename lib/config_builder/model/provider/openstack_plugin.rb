# @see https://github.com/cloudbau/vagrant-openstack-plugin
class ConfigBuilder::Model::Provider::OpenstackPlugin < ConfigBuilder::Model::Base

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

  def initialize
    @defaults = {}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'openstack' do |config|
        # Credentials
        with_attr(:username)                              { |val| config.username = val }
        with_attr(:api_key)                               { |val| config.api_key  = val }
        with_attr(:tenant)                                { |val| config.tenant = val }
        with_attr(:region)                                { |val| config.region = val }
        with_attr(:endpoint)                              { |val| config.endpoint = val }
        with_attr(:proxy)                                 { |val| config.proxy = val }
        with_attr(:ssl_verify_peer)                       { |val| config.ssl_verify_peer = val }
        # VM Configuration
        with_attr(:server_name)                           { |val| config.server_name = val }
        with_attr(:flavor)                                { |val| config.flavor = val }
        with_attr(:image)                                 { |val| config.image = val }
        with_attr(:availability_zone)                     { |val| config.availability_zone = val }
        with_attr(:security_groups)                       { |val| config.security_groups = val }
        with_attr(:user_data)                             { |val| config.user_data = val }
        with_attr(:metadata)                              { |val| config.metadata = val }
        with_attr(:scheduler_hints)                       { |val| config.scheduler_hints = val }
        # Floating IPs
        with_attr(:floating_ip)                           { |val| config.floating_ip = val }
        with_attr(:floating_ip_pool)                      { |val| config.floating_ip_pool = val }
        # Networks
        with_attr(:network)                               { |val| config.network = val }
        with_attr(:networks)                              { |val| config.networks = val }
        with_attr(:address_id)                            { |val| config.address_id = val }
        # Disks
        with_attr(:disks)                                 { |val| config.disks = val }
        # Orchestration Stacks
        with_attr(:orchestration_stack_name)              { |val| config.orchestration_stack_name = val }
        with_attr(:orchestration_stack_destroy)           { |val| config.orchestration_stack_destroy = val }
        with_attr(:orchestration_cfn_template)            { |val| config.orchestration_cfn_template = val }
        with_attr(:orchestration_cfn_template_file)       { |val| config.orchestration_cfn_template_file = val }
        with_attr(:orchestration_cfn_template_url)        { |val| config.orchestration_cfn_template_url = val }
        with_attr(:orchestration_cfn_template_parameters) { |val| config.orchestration_cfn_template_parameters = val }
        # SSH authentication
        with_attr(:keypair_name)                          { |val| config.keypair_name = val }
        with_attr(:ssh_username)                          { |val| config.ssh_username = val }
        with_attr(:ssh_ip_family)                         { |val| config.ssh_ip_family = val }
      end
    end
  end

  ConfigBuilder::Model::Provider.register('openstack_plugin', self)
end
