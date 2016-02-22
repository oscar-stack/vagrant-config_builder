# @see https://github.com/audiolize/vagrant-softlayer
class ConfigBuilder::Model::Provider::SoftLayer < ConfigBuilder::Model::Base
  def_model_attribute :api_key
  def_model_attribute :endpoint_url
  def_model_attribute :username

  def_model_attribute :manage_dns

  def_model_attribute :datacenter
  def_model_attribute :dedicated
  def_model_attribute :disk_capacity
  def_model_attribute :domain
  def_model_attribute :force_private_ip
  def_model_attribute :hostname
  def_model_attribute :hourly_billing
  def_model_attribute :image_guid
  def_model_attribute :local_disk
  def_model_attribute :max_memory
  def_model_attribute :network_speed
  def_model_attribute :operating_system
  def_model_attribute :post_install
  def_model_attribute :private_only
  def_model_attribute :start_cpus
  def_model_attribute :user_data
  def_model_attribute :vlan_private
  def_model_attribute :vlan_public
  def_model_attribute :ssh_key
  # Aliases for ssh_key
  def_model_attribute :ssh_keys
  def_model_attribute :ssh_key_id
  def_model_attribute :ssh_key_ids
  def_model_attribute :ssh_key_name
  def_model_attribute :ssh_key_names

  def_model_attribute :api_timeout
  def_model_attribute :provision_timeout
  def_model_attribute :rebuild_timeout
  def_model_attribute :transaction_wait

  def_model_delegator :load_balancers

  def initialize
    @defaults = {}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'softlayer' do |config|
        # Authentication
        with_attr(:api_key)           { |val| config.api_key = val }
        with_attr(:endpoint_url)      { |val| config.endpoint_url = val }
        with_attr(:username)          { |val| config.username = val }
        # DNS Management
        with_attr(:manage_dns)        { |val| config.manage_dns = val }
        # Instance Configuration
        with_attr(:datacenter)        { |val| config.datacenter = val }
        with_attr(:dedicated)         { |val| config.dedicated = val }
        with_attr(:disk_capacity)     { |val| config.disk_capacity = val }
        with_attr(:domain)            { |val| config.domain = val }
        with_attr(:force_private_ip)  { |val| config.force_private_ip = val }
        with_attr(:hostname)          { |val| config.hostname = val }
        with_attr(:hourly_billing)    { |val| config.hourly_billing = val }
        with_attr(:image_guid)        { |val| config.image_guid = val }
        with_attr(:local_disk)        { |val| config.local_disk = val }
        with_attr(:max_memory)        { |val| config.max_memory = val }
        with_attr(:network_speed)     { |val| config.network_speed = val }
        with_attr(:operating_system)  { |val| config.operating_system = val }
        with_attr(:post_install)      { |val| config.post_install = val }
        with_attr(:private_only)      { |val| config.private_only = val }
        with_attr(:start_cpus)        { |val| config.start_cpus = val }
        with_attr(:user_data)         { |val| config.user_data = val }
        with_attr(:vlan_private)      { |val| config.vlan_private = val }
        with_attr(:vlan_public)       { |val| config.vlan_public = val }
        with_attr(:ssh_key)           { |val| config.ssh_key = val }
        # Aliases for ssh_key
        with_attr(:ssh_keys)          { |val| config.ssh_keys = val }
        with_attr(:ssh_key_id)        { |val| config.ssh_key_id = val }
        with_attr(:ssh_key)           { |val| config.ssh_key = val }
        with_attr(:ssh_key_name)      { |val| config.ssh_key_name = val }
        with_attr(:ssh_key_names)     { |val| config.ssh_key_names = val }
        # Timeouts/Waits
        with_attr(:api_timeout)       { |val| config.api_timeout = val }
        with_attr(:provision_timeout) { |val| config.provision_timeout = val }
        with_attr(:rebuild_timeout)   { |val| config.rebuild_timeout = val }
        with_attr(:transaction_wait)  { |val| config.transaction_wait = val }
        # Load Balancers
        eval_models(config)
      end
    end
  end
  
  private

  def eval_load_balancers(config)
    attr(:load_balancers).each do |hash|
      v = ConfigBuilder::Model::Provider::SoftLayer::LoadBalancer.new_from_hash(hash)
      v.call(config)
    end
  end

  class LoadBalancer < ConfigBuilder::Model::Base

    def_model_attribute :destination_port
    def_model_attribute :health_check
    def_model_attribute :weight

    def to_proc
      Proc.new do |config|
        config.join_load_balancer service_group_opts do |service|
          with_attr(:destination_port) { |val| service.destination_port = val }
          with_attr(:health_check)     { |val| service.health_check = val }
          with_attr(:weight)           { |val| service.weight = val }
        end
      end
    end

    def service_group_opts
      h = {}
      with_attr(:method) { |val| h[:method] = val }
      with_attr(:port)   { |val| h[:port] = val }
      with_attr(:type)   { |val| h[:type] = val }
      with_attr(:vip)    { |val| h[:vip] = val }
      h
    end

  end

  ConfigBuilder::Model::Provider.register('softlayer', self)
end
