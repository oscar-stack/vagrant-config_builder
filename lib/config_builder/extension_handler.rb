module ConfigBuilder
  # Welcome to hell.
  # @api private
  class ExtensionHandler
    def initialize
      @logger = Log4r::Logger.new('vagrant::config_builder::extension_handler')
    end

    def load_from_plugins
      Vagrant.plugin('2').manager.registered.each do |plugin|
        load_plugin(plugin)
      end
    end

    def load_plugin(plugin)
      if plugin.respond_to? :config_builder_hook
        @logger.info "Loading config_builder extension #{plugin.inspect}"
        plugin.config_builder_hook
      end
    end
  end
end
