module ConfigBuilder
  module Action
    class LoadExtensions
      def initialize(app, env)
        @app, @env = app, env
      end

      def call(hash)
        hash[:env].hook(:config_builder_extension)
        @app.call(hash)
      end
    end
  end
end
