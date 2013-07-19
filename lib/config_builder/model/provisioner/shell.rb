# @see http://docs.vagrantup.com/v2/provisioning/shell.html
class ConfigBuilder::Model::Provisioner::Shell

  # @!attribute [rw] inline
  #   @return [String] The inline shell command to run
  attr_accessor :inline

  # @!attribute [rw] path
  #   @return [String] The path to the shell script to run
  attr_accessor :path

  # @!attribute [rw] args
  #   @return [String] A string acting as an argument vector to the command.
  attr_accessor :args

end
