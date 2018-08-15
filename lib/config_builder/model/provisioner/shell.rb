# @see http://docs.vagrantup.com/v2/provisioning/shell.html
class ConfigBuilder::Model::Provisioner::Shell < ConfigBuilder::Model::Provisioner::Base

  # @!attribute [rw] inline
  #   @return [String] The inline shell command to run
  def_model_attribute :inline

  # @!attribute [rw] path
  #   @return [String] The path to the shell script to run
  def_model_attribute :path

  # @!attribute [rw] args
  #   @return [String] A string acting as an argument vector to the command.
  def_model_attribute :args

  # @!attribute [rw] env
  #   @return [Hash] A hash of values passed in as environment variables to the script.
  def_model_attribute :env

  # @!attribute [rw] binary
  #   @return [Boolean] Whether Windows line endings are replaced with Unix line endings.
  def_model_attribute :binary

  # @!attribute [rw] privileged
  #   @return [Boolean] Specifies whether to execute the script as a privileged user or not.
  def_model_attribute :privileged

  # @!attribute [rw] upload_path
  #   @return [String] The remote path where the shell script will be uploaded to.
  def_model_attribute :upload_path

  # @!attribute [rw] keep_color
  #   @return [Boolean] Whether Vagrant should use coloring for the output.
  def_model_attribute :keep_color

  # @!attribute [rw] powershell_args
  #   @return [String] Extra arguments to pass to PowerShell if you are provisioning with PowerShell on Windows.
  def_model_attribute :powershell_args

  # @!attribute [rw] powershell_elevated_interactive
  #   @return [Boolean] Whether to run an elevated script in interactive mode on Windows.
  def_model_attribute :powershell_elevated_interactive

  # @!attribute [rw] md5
  #   @return [String]
  def_model_attribute :md5

  # @!attribute [rw] sha1
  #   @return [String]
  def_model_attribute :sha1

  # @!attribute [rw] sensitive
  #   @return [Boolean]
  def_model_attribute :sensitive

  ConfigBuilder::Model::Provisioner.register('shell', self)
end
