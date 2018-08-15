# @see https://github.com/nsidc/vagrant-vsphere
class ConfigBuilder::Model::Provider::Vsphere< ConfigBuilder::Model::Provider::Base

  def_model_attribute :host
  def_model_attribute :insecure
  def_model_attribute :user
  def_model_attribute :password
  def_model_attribute :data_center_name
  def_model_attribute :compute_resource_name
  def_model_attribute :resource_pool_name
  def_model_attribute :clone_from_vm
  def_model_attribute :template_name
  def_model_attribute :name
  def_model_attribute :vm_base_path
  def_model_attribute :customization_spec_name
  def_model_attribute :data_store_name
  def_model_attribute :linked_clone
  def_model_attribute :proxy_host
  def_model_attribute :proxy_port
  def_model_attribute :vlan
  def_model_attribute :addressType
  def_model_attribute :mac
  def_model_attribute :memory_mb
  def_model_attribute :cpu_count
  def_model_attribute :cpu_reservation
  def_model_attribute :mem_reservation
  def_model_attribute :real_nic_ip
  def_model_attribute :ip_address_timeout
  def_model_attribute :wait_for_sysprep

  def_model_attribute :custom_attributes
  def_model_attribute :extra_config
  def_model_attribute :notes

  def instance_id
    'vsphere'
  end

  # @private
  def config_custom_attributes(config, val)
    val.each do |e|
      config.custom_attribute(*e)
    end
  end

  ConfigBuilder::Model::Provider.register('vsphere', self)
end
