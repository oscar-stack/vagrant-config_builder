require 'yaml'

class ConfigBuilder::Loader::YAML

  # Load configuration from all files in a given directory
  #
  # @param dir_path [String]
  #
  # @return [Hash]
  def yamldir(dir_path)
    glob_path = File.join(dir_path, '*.yaml')

    rv = {}
    Dir.glob(glob_path).each do |file|
      contents = ::YAML.load_file(file)
      rv.merge!(contents)
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
end
