# @see http://docs.vagrantup.com/v2/provisioning/shell.html
class ConfigBuilder::Model::Provisioner::Shell < ConfigBuilder::Model::Base

  # @!attribute [rw] inline
  #   @return [String] The inline shell command to run
  def_model_attribute :inline

  # @!attribute [rw] path
  #   @return [String] The path to the shell script to run
  def_model_attribute :path

  # @!attribute [rw] args
  #   @return [String] A string acting as an argument vector to the command.
  def_model_attribute :args


  # @!attribute [rw] run
  #   @return [String] Defaults to not set. If set to 'always' will cause provisioner to always run.
  def_model_attribute :run

  def initialize
    @defaults = {
     :run => 'once',
    }
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :shell, run: attr(:run) do |shell_config|
        with_attr(:inline) { |val| shell_config.inline = val }
        with_attr(:path)   { |val| shell_config.path   = val }
        with_attr(:args)   { |val| shell_config.args   = val }
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('shell', self)
end
