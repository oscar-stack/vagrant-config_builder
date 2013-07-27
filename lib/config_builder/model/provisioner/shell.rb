# @see http://docs.vagrantup.com/v2/provisioning/shell.html
class ConfigBuilder::Model::Provisioner::Shell < ConfigBuilder::Model::Base

  # @!attribute [rw] inline
  #   @return [String] The inline shell command to run
  attr_accessor :inline

  # @!attribute [rw] path
  #   @return [String] The path to the shell script to run
  attr_accessor :path

  # @!attribute [rw] args
  #   @return [String] A string acting as an argument vector to the command.
  attr_accessor :args

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :shell do |shell_config|
        shell_config.inline = @inline if defined? @inline
        shell_config.path   = @path   if defined? @path
        shell_config.args   = @args   if defined? @args
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('shell', self)
end
