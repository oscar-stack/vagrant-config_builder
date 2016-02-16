# Model the root level Vagrant config object
#
# @see http://docs.vagrantup.com/v2/vagrantfile/index.html
class ConfigBuilder::Model::Root < ConfigBuilder::Model::Base

  include ConfigBuilder::ModelDelegator

  def_model_delegator :vagrant
  def_model_delegator :vms
  def_model_delegator :vm_defaults

  # @!attribute [rw] ssh
  #   @return [Hash<Symbol, Object>] The ssh configuration for all VMs
  #   @example
  #     >> config.ssh
  #     => {
  #           :username => 'administrator',
  #           :password => 'vagrant',
  #        }
  def_model_delegator :ssh

  # @!attribute [rw] nfs
  #   @return [Hash<Symbol, Object>] The nfs configuration for all VMs
  #   @example
  #     >> config.nfs
  #     => {
  #           :nfs_export  => true,
  #           :nfs_version => 4
  #        }
  def_model_delegator :nfs

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
    @defaults = {:vms => [], :vagrant => {}}
  end

  def to_proc
    Proc.new do |root_config|
      eval_models(root_config)
    end
  end

  private

  def eval_vm_defaults(root_config)
    with_attr(:vm_defaults) do |hash|
      v = ConfigBuilder::Model::VM.new_from_hash(hash)
      v.call(root_config)
    end
  end

  def eval_vms(root_config)
    attr(:vms).each do |hash|
      v = ConfigBuilder::Model::VM.new_from_hash(hash)
      root_config.vm.define(v.instance_id, v.instance_options) do |vm_config|
        v.call(vm_config)
      end
    end
  end

  def eval_vagrant(root_config)
    if attr(:vagrant).has_key? :host
      root_config.vagrant.host = attr(:vagrant)[:host]
    end
  end

  def eval_nfs(root_config)
    with_attr(:nfs) do |nfs_config|
      f = ConfigBuilder::Model::NFS.new_from_hash(nfs_config)
      f.call(root_config)
    end
  end

  def eval_ssh(root_config)
    with_attr(:ssh) do |ssh_config|
      f = ConfigBuilder::Model::SSH.new_from_hash(ssh_config)
      f.call(root_config)
    end
  end

  def eval_winrm(root_config)
    if attr(:winrm)
      f = ConfigBuilder::Model::WinRM.new_from_hash(attr(:winrm))
      f.call(root_config)
    end
  end
end
