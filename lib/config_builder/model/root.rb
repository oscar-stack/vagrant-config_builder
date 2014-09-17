# Model the root level Vagrant config object
#
# @see http://docs.vagrantup.com/v2/vagrantfile/index.html
class ConfigBuilder::Model::Root < ConfigBuilder::Model::Base

  include ConfigBuilder::ModelDelegator

  def_model_delegator :vagrant
  def_model_delegator :ssh
  def_model_delegator :vms

  # @!attribute [rw] winrm
  #   @return [Hash<Symbol, Object>] The winrm configuration for all VMs
  #   @example
  #     >> config.winrm
  #     => {
  #           :username => 'administrator',
  #           :password => 'vagrant',
  #        }
  def_model_delegator :winrm

  def initialize
    @defaults = {:vms => [], :vagrant => {}, :winrm => {}}
  end

  def to_proc
    Proc.new do |root_config|
      eval_models(root_config)
    end
  end

  private

  def eval_vms(root_config)
    attr(:vms).each do |hash|
      v = ConfigBuilder::Model::VM.new_from_hash(hash)
      v.call(root_config)
    end
  end

  def eval_vagrant(root_config)
    if attr(:vagrant).has_key? :host
      root_config.vagrant.host = attr(:vagrant)[:host]
    end
  end

  def eval_ssh(root_config)

  end

  def eval_winrm(root_config)
    f = ConfigBuilder::Model::WinRM.new_from_hash(attr(:winrm))
    f.call(root_config)
  end
end
