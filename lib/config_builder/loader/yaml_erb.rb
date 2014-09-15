require 'erb'

class ConfigBuilder::Loader::YAML_ERB < ConfigBuilder::Loader::YAML

  # Load configuration from a YAML file with ERB interpolation first
  #
  # @param file_path [String]
  #
  # @example the following config file will be processed by ERB first so it can
  # determine whether to use the environment variable 'VAGRANT_MANIFEST' or the
  # default value 'init.pp' for the puppet manifest file.
  #
  # ---
  #   provisioner:
  #     - type: puppet
  #       manifest_file: <%= ENV['VAGRANT_MANIFEST'] || 'init.pp' >
  #
  # @return [Hash]
  def yamlfile(file_path)
    ::YAML.load(::ERB.new(File.read(file_path)).result)
  end

  ConfigBuilder::Loader.register(:yaml_erb, self)
end
