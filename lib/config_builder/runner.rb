require 'config_builder/loader'
require 'config_builder/model'

module ConfigBuilder
  class Runner

    def run(identifier, method, value)
      data = ConfigBuilder::Loader.generate(identifier, method, value)
      filtered_data = run_filters(data)
      model = generate_model(filtered_data)
    end

    private

    def run_filters(data)

    end

    def generate_model(filtered_hash)

    end
  end
end
