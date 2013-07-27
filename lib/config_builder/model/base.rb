# A ConfigBuilder model implements a logic-less interface to a component of
# Vagrant.
#
# A model should implement the following methods:
#
# ## `self.new_from_hash`
#
# This method takes an arbitrarily nested data structure of basic data types
# (Arrays, Hashes, Numerics, Strings, etc) and instantiates a new object
# with attributes set based on that data structure.
#
# ## `#to_proc`
#
# This method takes the object attributes and generates a lambda that will
# create a Vagrant config with the state specified by the attributes. The
# lambda should have an arity of one and should be passed a `config` object.
# The generated block will generate the Vagrant config that implements the
# behavior specified by the object attributes.
#
# If the Model delegates certain configuration to other models, the generated
# lambda should be able to evaluate lambdas from the delegated models.
#
# Implementing classes do not need to inherit from ConfigBuilder::Model::Base,
# but it makes life easier.
class ConfigBuilder::Model::Base

  # Deserialize a hash into a configbuilder model
  #
  # @param attributes [Hash] The model attributes as represented in a hash.
  # @return [Object < ConfigBuilder::Model]
  def self.new_from_hash(attributes)
    obj = new()
    obj.attributes_from_hash(attributes)
    obj
  end

  # Populate model attributes from a hash
  #
  # @param attributes [Hash] The model attributes as represented in a hash.
  # @return [void]
  def attributes_from_hash(attributes)
    attributes.each_pair do |attr, value|
      setter = "#{attr}=".intern
      if respond_to? setter
        send(setter, value)
      else
        raise ConfigBuilder::Model::UnknownAttributeError, "attribute #{attr} undefined on #{self.class.inspect}"
      end
    end
  end

  # Generate a block based on configuration specified by the attributes
  #
  # @abstract
  # @return [Proc]
  def to_proc
    raise NotImplementedError
  end

  # Generate a block based on the attribute configuration and call it with
  # the given config.
  #
  # @param [Vagrant.plugin('2', :config)]
  # @return [void]
  def call(config)
    to_proc.call(config)
  end
end
