require 'vagrant/errors'

module ConfigBuilder

  # This defines a registry for classes, and behaves as a factory for registered classes.
  #
  # @api private
  class ClassRegistry

    class UnknownEntry < Vagrant::Errors::VagrantError
      error_key('unknown_entry', 'config_builder.class_registry')
    end

    class DuplicateEntry < Vagrant::Errors::VagrantError
      error_key('duplicate_entry', 'config_builder.class_registry')
    end

    def initialize(name)
      @name    = name
      @klasses = {}
    end

    # Register a class with a given identifier
    #
    # @param identifier [Symbol]
    # @param klass [Class]
    #
    # @return [void]
    def register(identifier, klass)
      if @klasses[identifier]
        raise DuplicateEntry, :registry => @name,
                              :identifiers => @klasses.keys
      else
        @klasses[identifier] = klass
      end
    end

    # Retrieve a class associated with the specified identifier
    #
    # @param identifier [Symbol]
    #
    # @return [Class]
    def retrieve(identifier)
      if (klass = @klasses[identifier])
        klass
      else
        raise UnknownEntry, :registry  => @name,
                            :identifier => identifier.inspect,
                            :identifiers => @klasses.keys
      end
    end

    # Generate a class instance with the given hash
    #
    # @param hash [Hash] The identifier and options for the new object
    # @option hash type [String] The identifier of the class to instantiate
    #
    # @return [Object] The generated object
    def generate(hash)
      identifier = hash.delete('type')

      klass = retrieve(identifier)

      klass.new_from_hash(hash)
    end

    def inspect
      "<#{self.class}: (#{@name})>"
    end
  end
end
