# @see https://github.com/nsidc/vagrant-vsphere
class ConfigBuilder::Model::Provider::Vsphere< ConfigBuilder::Model::Base

  VSPHERE_ATTRIBUTES = [ :host, :insecure, :user, :password, :data_center_name, :compute_resource_name, :resource_pool_name, :clone_from_vm, :template_name, :name, :vm_base_path, :customization_spec_name, :data_store_name, :linked_clone, :proxy_host, :proxy_port, :vlan ]

  # @!attribute [rw]
  # The mandatory attributes will be verified by vagrant-vsphere
  # @see https://github.com/nsidc/vagrant-vsphere#configuration
  VSPHERE_ATTRIBUTES.each do |key|
    def_model_attribute attr
  end

  def initialize
    @defaults = {
      :insecure => false,
    }
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'vsphere' do |config|
        VSPHERE_ATTRIBUTES.each do |key|
          config.send("#{key}=", attr(key)) if attr(key)
        end
      end
    end
  end

  ConfigBuilder::Model::Provider.register('vsphere', self)
end
