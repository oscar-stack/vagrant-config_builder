require 'vagrant'

module ConfigBuilder
  require 'config_builder/loader'
  require 'config_builder/model'
  require 'config_builder/plugin'
  require 'config_builder/version'

  def self.load(identifier, method, value)
    if identifier != :yaml
      raise NotImplementedError, "Multiple loader backends are not implemented"
    end

    loader = ConfigBuilder::Loader::YAML.new
    data   = loader.send(method, value)

    ConfigBuilder::Model::Root.new_from_hash(data)
  end
end
