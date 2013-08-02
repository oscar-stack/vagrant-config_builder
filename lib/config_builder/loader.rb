require 'config_builder/class_registry'

module ConfigBuilder
  module Loader
    @registry = ConfigBuilder::ClassRegistry.new(:loader)

    def self.register(identifier, klass)
      @registry.register(identifier, klass)
    end

    def self.retrieve(identifier)
      @registry.retrieve(identifier)
    end

    require 'config_builder/loader/yaml'
  end
end
