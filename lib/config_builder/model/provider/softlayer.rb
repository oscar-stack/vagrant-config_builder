# @see https://github.com/audiolize/vagrant-softlayer
class ConfigBuilder::Model::Provider::SoftLayer < ConfigBuilder::Model::Provider::Base
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

  def instance_id
    'softlayer'
  end

  private

  def eval_load_balancers(configs)
    provider, _ = configs

    attr(:load_balancers).each do |hash|
      v = ConfigBuilder::Model::Provider::SoftLayer::LoadBalancer.new_from_hash(hash)
      v.call(provider)
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
