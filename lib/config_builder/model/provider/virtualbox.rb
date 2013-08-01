# @see http://docs.vagrantup.com/v2/virtualbox/configuration.html
class ConfigBuilder::Model::Provider::Virtualbox < ConfigBuilder::Model::Base

  # @!attribute [rw] name
  #   @return [String] The name of the created VM in the Virtualbox GUI
  def_model_attribute :name

  # @!attribute [rw] customize
  #   @return [Array<String>] A list of customize arguments to use upon VM instantiation.
  def_model_attribute :customize

  # @!attribute [rw] gui
  #   @return [Boolean] Whether the GUI should be launched when the VM is created
  def_model_attribute :gui

  def initialize
    @defaults = {:customize => []}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'virtualbox' do |vb_config|
        vb_config.name = attr(:name) if attr(:name)

        attr(:customize).each do |cmd|
          vb_config.customize cmd
        end

        vb_config.gui = attr(:gui) if attr(:gui)
      end
    end
  end

  ConfigBuilder::Model::Provider.register('virtualbox', self)
end
