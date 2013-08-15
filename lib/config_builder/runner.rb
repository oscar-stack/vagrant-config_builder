require 'config_builder/loader'
require 'config_builder/filter_stack'
require 'config_builder/model'
require 'config_builder/extension_handler'

module ConfigBuilder
  class Runner

    def run(identifier, method, value)
      load_extensions

      data = ConfigBuilder::Loader.generate(identifier, method, value)
      filtered_data = run_filters(data)
      model = generate_model(filtered_data)
    end

    private

    def load_extensions
      ext = ConfigBuilder::ExtensionHandler.new
      ext.load_from_plugins
    end

    def run_filters(data)
      stack = ConfigBuilder::FilterStack.new
      stack.filter(data)
    end

    def generate_model(filtered_hash)
      ConfigBuilder::Model.generate(filtered_hash)
    end
  end
end
