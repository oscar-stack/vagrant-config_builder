# @see https://github.com/ggiamarchi/vagrant-openstack-provider
class ConfigBuilder::Model::Provider::Openstack < ConfigBuilder::Model::Provider::Base

  # Credentials
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
  def_model_attribute :ssl_ca_file
  def_model_attribute :ssl_verify_peer

  # Keystone v3 Credentials
  def_model_attribute :identity_api_version
  def_model_attribute :domain_name
  def_model_attribute :project_name
  def_model_attribute :project_domain_name
  def_model_attribute :interface_type
  def_model_attribute :user_domain_name

  # VM Configuration
  def_model_attribute :server_name
  def_model_attribute :flavor
  def_model_attribute :image
  def_model_attribute :availability_zone
  def_model_attribute :security_groups
  def_model_attribute :user_data
  def_model_attribute :metadata
  def_model_attribute :meta_args_support
  def_model_attribute :scheduler_hints
  def_model_attribute :use_legacy_synced_folders

  # Floating IPs
  def_model_attribute :floating_ip
  def_model_attribute :floating_ip_pool
  def_model_attribute :floating_ip_pool_always_allocate

  # Networks
  def_model_attribute :networks

  # Volumes
  def_model_attribute :volumes
  def_model_attribute :volume_boot

  # Orchestration Stacks
  def_model_attribute :stacks
  def_model_attribute :stack_create_timeout
  def_model_attribute :stack_delete_timeout

  # SSH authentication
  def_model_attribute :keypair_name
  def_model_attribute :public_key_path
  def_model_attribute :ssh_username
  def_model_attribute :ssh_disabled
  def_model_attribute :ssh_timeout

  # Synced folders
  def_model_attribute :sync_method
  def_model_attribute :rsync_includes
  def_model_attribute :rsync_ignore_files

  # Timeouts
  def_model_attribute :server_create_timeout
  def_model_attribute :server_active_timeout
  def_model_attribute :server_stop_timeout
  def_model_attribute :server_delete_timeout
  def_model_attribute :http
  def_model_attribute :floating_ip_assign_timeout

  def instance_id
    'openstack'
  end

  # @private
  def configure_http(config, val)
    val.each do |k, v|
      case k.to_sym
      when :open_timeout
        config.http.open_timeout = val
      when :read_timeout
        config.http.read_timeout = val
      when :proxy
        config.http.proxy = val
      end
    end
  end

  ConfigBuilder::Model::Provider.register('openstack', self)
end
