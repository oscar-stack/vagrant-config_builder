require 'config_builder' # For logging.

module ConfigBuilder
  module ModelDelegator
    def self.included(klass)
      ConfigBuilder.logger.warn {
        I18n.t('config_builder.model_delegator.is_deprecated', :name => klass.inspect)
      }
    end
  end
end
