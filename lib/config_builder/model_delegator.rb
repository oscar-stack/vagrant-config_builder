module ConfigBuilder
  module ModelDelegator

    def model_delegators
      self.class.model_delegators
    end

    def eval_models(config)
      model_delegators.each do |model|
        meth = "eval_#{model}"
        send(meth, config)
      end
    end

    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def def_model_delegator(identifier)
        attr_accessor identifier
        model_delegators << identifier
      end

      def model_delegators
        (@models ||= [])
      end
    end
  end
end
