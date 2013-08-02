require 'vagrant'

module ConfigBuilder
  require 'config_builder/loader'
  require 'config_builder/model'
  require 'config_builder/plugin'
  require 'config_builder/version'

  def self.load(identifier, method, value)
    loader = ConfigBuilder::Loader.retrieve(identifier).new
    data   = loader.send(method, value)

    ConfigBuilder::Model::Root.new_from_hash(data)
  end
end
