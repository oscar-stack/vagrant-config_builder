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

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :shell do |shell_config|
        shell_config.inline = attr(:inline) if attr(:inline)
        shell_config.path   = attr(:path)   if attr(:path)
        shell_config.args   = attr(:args)   if attr(:args)
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('shell', self)
end
