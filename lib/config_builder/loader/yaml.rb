require 'yaml'

class ConfigBuilder::Loader::YAML

  # Load configuration from all files in a given directory
  #
  # @param dir_path [String]
  #
  # @return [Hash]
  def yamldir(dir_path)
    glob_path = File.join(dir_path, '*.{yml,yaml}')

    rv = {}
    Dir.glob(glob_path).each do |file|
      contents = ::YAML.load_file(file)

      if contents.is_a? Hash
        rv.merge! contents
      else
        # TODO warn on non-hash YAML
      end
    end

    rv
  end

  # Load configuration from a file
  #
  # @param file_path [String]
  #
  # @return [Hash]
  def yamlfile(file_path)
    ::YAML.load_file(file_path)
  end

  ConfigBuilder::Loader.register(:yaml, self)
end
