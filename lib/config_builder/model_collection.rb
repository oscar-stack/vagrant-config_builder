require 'vagrant/errors'

module ConfigBuilder
  class ModelCollection

    class UnknownModelError < Vagrant::Errors::VagrantError; end

    def initialize(name)
      @name = name
      @model_klasses = {}
    end

    def register(identifier, klass)
      @model_klasses[identifier] = klass
    end

    def generate(hash)
      identifier = hash.delete('type')

      if (klass = @model_klasses[identifier])
        klass.new_from_hash(hash)
      else
        raise UnknownModelError, "#{self.inspect} doesn't have a model registered with key #{identifier.inspect}"
      end
    end

    def inspect
      "<#{self.class}: (#{@name})>"
    end

    class << self

      def provider
        @provider ||= self.new(:provider)
      end

      def provisioner
        @provisioner ||= self.new(:provisioner)
      end
    end
  end
end
