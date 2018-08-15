# @see http://docs.vagrantup.com/v2/provisioning/puppet_apply.html
class ConfigBuilder::Model::Provisioner::Puppet < ConfigBuilder::Model::Provisioner::Base

  # @!attribute [rw] binary_path
  #   @return [String] The path to Puppet's `bin` directory.
  def_model_attribute :binary_path

  # @!attribute [rw] manifests_path
  #   @return [String] The path to the puppet manifests.
  def_model_attribute :manifests_path

  # @!attribute [rw] manifest_file
  #   @return [String] The name of the manifest to apply
  def_model_attribute :manifest_file

  # @!attribute [rw] module_path
  #   @return [String] A colon separated set of filesystem paths for Puppet
  def_model_attribute :module_path

  # @!attribute [rw] facter
  #   @return [Hash] A hash of values to use as facts
  def_model_attribute :facter

  # @!attribute [rw] options
  #   @return [String] An arbitrary set of arguments for the `puppet` command
  def_model_attribute :options

  # @!attribute [rw] hiera_config_path
  #   @return [String] Path to the Hiera configuration file stored on the host
  #   @since 0.15.0
  def_model_attribute :hiera_config_path

  # @!attribute [rw] working_directory
  #   @return [String] Path in the guest that will be the working directory when Puppet is executed
  #   @since 0.15.0
  def_model_attribute :working_directory

  # @!attribute [rw] environment
  #   @return [String] Name of the Puppet environment.
  def_model_attribute :environment

  # @!attribute [rw] environment_path
  #   @return [String] Path to the directory that contains environment files on the host disk.
  def_model_attribute :environment_path

  # @!attribute [rw] environment_variables
  #   @return [Hash]
  def_model_attribute :environment_variables

  # @!attribute [rw] synced_folder_type
  #   @return [String] The type of synced folders to use when sharing the data required for the provisioner to work properly.
  def_model_attribute :synced_folder_type

  # @!attribute [rw] synced_folder_args
  #   @return [Array<String>] Arguments that are passed to the folder sync.
  def_model_attribute :synced_folder_args

  # @!attribute [rw] temp_dir
  #   @return [String] The directory where the data associated with the Puppet run will be stored on the guest machine.
  def_model_attribute :temp_dir

  ConfigBuilder::Model::Provisioner.register('puppet', self)
end
