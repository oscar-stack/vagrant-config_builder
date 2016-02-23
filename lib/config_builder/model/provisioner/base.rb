# Abstract base class for Vagrant provisioners
#
# @abstract
#
# @since 0.16.0
#
# @see https://www.vagrantup.com/docs/provisioning/basic_usage.html
class ConfigBuilder::Model::Provisioner::Base < ConfigBuilder::Model::Base
  def_model_option :name
  def_model_option :type
  def_model_option :run
  def_model_option :preserve_order

  def to_proc
    Proc.new do |vm_config|
      options = instance_options

      name = options.delete(:name)
      if name.nil?
        name = options.delete(:type)
      elsif Vagrant::VERSION < '1.7'
        # Vagrant 1.6 and earlier used "id" instead of "name".
        options[:id] = name
        name = options.delete(:type)
      end

      vm_config.provision(name, **options) do |config|
        configure!(config)
        eval_models(config)
      end
    end
  end
end
