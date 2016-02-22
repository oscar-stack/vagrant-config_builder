# Abstract base class for Vagrant providers
#
# @abstract
#
# @since 0.16.0
#
# @see https://www.vagrantup.com/docs/providers/configuration.html
class ConfigBuilder::Model::Provider::Base < ConfigBuilder::Model::Base
  def_model_delegator :overrides

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider instance_id do |config, overrides|
        configure!(config)

        # NOTE: All models inheriting from this class need to provide
        # delegators which can consume a tuple of provider and override
        # configuration.
        eval_models([config, overrides])
      end
    end
  end

  def eval_overrides(configs)
    with_attr(:overrides) do |hash|
      _, overrides = configs
      r = ConfigBuilder::Model::Root.new_from_hash(hash)
      r.call(overrides)
    end
  end

  # Set this to the name of the 'provider': 'vsphere', 'openstack', 'vmware',
  # etc.
  def instance_id
    raise NotImplementedError
  end
end
