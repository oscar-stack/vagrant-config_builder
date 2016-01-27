# @see https://github.com/ggiamarchi/vagrant-openstack-provider
class ConfigBuilder::Model::Provider::Openstack < ConfigBuilder::Model::Base

  def_model_attribute :username
  def_model_attribute :password
  def_model_attribute :tenant_name
  def_model_attribute :region
  def_model_attribute :openstack_auth_url
  def_model_attribute :openstack_compute_url
  def_model_attribute :openstack_network_url
  def_model_attribute :openstack_volume_url
  def_model_attribute :openstack_image_url
  def_model_attribute :openstack_orchestration_url
  def_model_attribute :endpoint_type

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
  def_model_attribute :floating_ip_pool_always_allocate

  def_model_attribute :networks

  def_model_attribute :volumes
  def_model_attribute :volume_boot

  def_model_attribute :stacks
  def_model_attribute :stack_create_timeout
  def_model_attribute :stack_delete_timeout

  def_model_attribute :keypair_name
  def_model_attribute :public_key_path
  def_model_attribute :ssh_username
  def_model_attribute :ssh_disabled
  def_model_attribute :ssh_timeout

  def_model_attribute :sync_method
  def_model_attribute :rsync_includes
  def_model_attribute :rsync_ignore_files

  def_model_attribute :server_create_timeout
  def_model_attribute :server_active_timeout
  def_model_attribute :server_stop_timeout
  def_model_attribute :server_delete_timeout
  def_model_attribute :http_open_timeout
  def_model_attribute :http_read_timeout

  def initialize
    @defaults = {}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'openstack' do |config|
        # Credentials
        with_attr(:username)                         { |val| config.username                    = val }
        with_attr(:password)                         { |val| config.password                    = val }
        with_attr(:tenant_name)                      { |val| config.tenant_name                 = val }
        with_attr(:region)                           { |val| config.region                      = val }
        with_attr(:openstack_auth_url)               { |val| config.openstack_auth_url          = val }
        with_attr(:openstack_compute_url)            { |val| config.openstack_compute_url       = val }
        with_attr(:openstack_network_url)            { |val| config.openstack_network_url       = val }
        with_attr(:openstack_volume_url)             { |val| config.openstack_volume_url        = val }
        with_attr(:openstack_image_url)              { |val| config.openstack_image_url         = val }
        with_attr(:openstack_orchestration_url)      { |val| config.openstack_orchestration_url = val }
        with_attr(:endpoint_type)                    { |val| config.endpoint_type               = val }
        # VM Configuration
        with_attr(:server_name)                      { |val| config.server_name                 = val }
        with_attr(:flavor)                           { |val| config.flavor                      = val }
        with_attr(:image)                            { |val| config.image                       = val }
        with_attr(:availability_zone)                { |val| config.availability_zone           = val }
        with_attr(:security_groups)                  { |val| config.security_groups             = val }
        with_attr(:user_data)                        { |val| config.user_data                   = val }
        with_attr(:metadata)                         { |val| config.metadata                    = val }
        with_attr(:scheduler_hints)                  { |val| config.scheduler_hints             = val }
        # Floating IPs
        with_attr(:floating_ip)                      { |val| config.floating_ip                 = val }
        with_attr(:floating_ip_pool)                 { |val| config.floating_ip_pool            = val }
        with_attr(:floating_ip_pool_always_allocate) { |val| config.floating_ip_pool_always_allocate = val }
        # Networks
        with_attr(:networks)                         { |val| config.networks                    = val }
        # Volumes
        with_attr(:volumes)                          { |val| config.volumes                     = val }
        with_attr(:volume_boot)                      { |val| config.volume_boot                 = val }
        # Orchestration Stacks
        with_attr(:stacks)                           { |val| config.stacks                      = val }
        with_attr(:stack_create_timeout)             { |val| config.stack_create_timeout        = val }
        with_attr(:stack_delete_timeout)             { |val| config.stack_delete_timeout        = val }
        # SSH authentication
        with_attr(:keypair_name)                     { |val| config.keypair_name                = val }
        with_attr(:public_key_path)                  { |val| config.public_key_path             = val }
        with_attr(:ssh_username)                     { |val| config.ssh_username                = val }
        with_attr(:ssh_disabled)                     { |val| config.ssh_disabled                = val }
        with_attr(:ssh_timeout)                      { |val| config.ssh_timeout                 = val }
        # Synced folders
        with_attr(:sync_method)                      { |val| config.sync_method                 = val }
        with_attr(:rsync_includes)                   { |val| config.rsync_includes              = val }
        with_attr(:rsync_ignore_files)               { |val| config.rsync_ignore_files          = val }
        # Timeouts
        with_attr(:server_create_timeout)            { |val| config.server_create_timeout       = val }
        with_attr(:server_active_timeout)            { |val| config.server_active_timeout       = val }
        with_attr(:server_stop_timeout)              { |val| config.server_stop_timeout         = val }
        with_attr(:server_delete_timeout)            { |val| config.server_delete_timeout       = val }
        with_attr(:http_open_timeout)                { |val| config.http.open_timeout           = val }
        with_attr(:http_read_timeout)                { |val| config.http.read_timeout           = val }
      end
    end
  end

  ConfigBuilder::Model::Provider.register('openstack', self)
end
