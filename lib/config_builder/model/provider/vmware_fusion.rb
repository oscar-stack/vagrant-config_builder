# @see http://docs.vagrantup.com/v2/vmware/configuration.html
class ConfigBuilder::Model::Provider::VMwareFusion < ConfigBuilder::Model::Base

  # @!attribute [rw] vmx
  #   @return [Hash<String, String>] A hash of VMX options for the given VM
  #   @example
  #     model.vmx = {
  #       'memsize'  => '1024',
  #       'numvcpus' => '2',
  #     }
  def_model_attribute :vmx

  # @!attribute [rw] gui
  #   @return [Boolean] Whether the GUI should be launched when the VM is created
  def_model_attribute :gui

  def initialize
    @defaults = {
      :gui => false,
      :vmx => {},
    }
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'vmware_fusion' do |fusion_config|
        fusion_config.gui = attr(:gui)
        attr(:vmx).each_pair do |key, value|
          fusion_config.vmx[key] = value
        end
      end
    end
  end

  ConfigBuilder::Model::Provider.register('vmware_fusion', self)
end
