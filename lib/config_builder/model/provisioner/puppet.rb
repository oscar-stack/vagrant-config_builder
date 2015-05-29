# @see http://docs.vagrantup.com/v2/provisioning/puppet_apply.html
class ConfigBuilder::Model::Provisioner::Puppet < ConfigBuilder::Model::Base

  # @!attribute [rw] manifests_path
  #   @return [String] The path to the puppet manifests.
  attr_accessor :manifests_path

  # @!attribute [rw] manifest_file
  #   @return [String] The name of the manifest to apply
  attr_accessor :manifest_file

  # @!attribute [rw] module_path
  #   @return [String] A colon separated set of filesystem paths for Puppet
  attr_accessor :module_path

  # @!attribute [rw] facter
  #   @return [Hash] A hash of values to use as facts
  attr_accessor :facter

  # @!attribute [rw] options
  #   @return [String] An arbitrary set of arguments for the `puppet` command
  attr_accessor :options

  # @!attribute [rw] hiera_config_path
  #   @return [String] Path to the Hiera configuration file stored on the host
  #   @since 0.15.0
  attr_accessor :hiera_config_path

  # @!attribute [rw] working_directory
  #   @return [String] Path in the guest that will be the working directory when Puppet is executed
  #   @since 0.15.0
  attr_accessor :working_directory

  # @!attribute [rw] run
  #   @return [String] Defaults to not set. If set to 'always' will cause provisioner to always run.
  attr_accessor :run

  def initialize
    @defaults = {
     :run => 'once',
    }
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.provision :puppet, run: attr(:run) do |puppet_config|
        with_attr(:manifests_path)    { |val| puppet_config.manifests_path    = val }
        with_attr(:manifest_file)     { |val| puppet_config.manifest_file     = val }
        with_attr(:module_path)       { |val| puppet_config.module_path       = val }
        with_attr(:facter)            { |val| puppet_config.facter            = val }
        with_attr(:options)           { |val| puppet_config.options           = val }
        with_attr(:hiera_config_path) { |val| puppet_config.hiera_config_path = val }
        with_attr(:working_directory) { |val| puppet_config.working_directory = val }
      end
    end
  end

  ConfigBuilder::Model::Provisioner.register('puppet', self)
end
