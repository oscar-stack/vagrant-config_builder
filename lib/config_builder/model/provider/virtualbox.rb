# @see http://docs.vagrantup.com/v2/virtualbox/configuration.html
class ConfigBuilder::Model::Provider::Virtualbox < ConfigBuilder::Model::Base

  # @!attribute [rw] name
  #   @return [String] The name of the created VM in the Virtualbox GUI
  attr_accessor :name

  # @!attribute [rw] customize
  #   @return [Array<String>] A list of customize arguments to use upon VM instantiation.
  attr_accessor :customize

  # @!attribute [rw] gui
  #   @return [Boolean] Whether the GUI should be launched when the VM is created
  attr_accessor :gui

  def initialize
    @customize = []
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provider 'virtualbox' do |vb_config|
        vb_config.name = @name if defined?(@name)

        @customize.each do |cmd|
          vb_config.customize cmd
        end

        vb_config.gui = @gui if defined?(@gui)
      end
    end
  end

  ConfigBuilder::Model::Provider.register('virtualbox', self)
end
