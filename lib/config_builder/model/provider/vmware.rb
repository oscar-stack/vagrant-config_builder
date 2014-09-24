# @see http://docs.vagrantup.com/v2/vmware/configuration.html
class ConfigBuilder::Model::Provider::VMware < ConfigBuilder::Model::Base

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

    @providers ||= %w[vmware_fusion vmware_workstation]
  end

  def to_proc
    Proc.new do |vm_config|
      @providers.each do |vmware_provider|
        vm_config.provider vmware_provider do |config|
          config.gui = attr(:gui)
          attr(:vmx).each_pair do |key, value|
            config.vmx[key] = value
          end
        end
      end
    end
  end

  ConfigBuilder::Model::Provider.register('vmware', self)
end
