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
  class << self
    # Define the model identifier
    #
    # This method defines an entry in the data structure which is to be used as
    # an identifier for generated model instances.
    #
    # @since 0.16.0
    #
    # @param identifier [Symbol]
    #
    # @return [Symbol] The identifier passed to `def_model_id`.
    def def_model_id(identifier)
      @model_id = identifier
    end

    # Fetch the model identifier
    #
    # @since 0.16.0
    #
    # @return [Symbol] The identifier defined using #{def_model_id}.
    attr_reader :model_id

    # Define a new model attribute
    #
    # Model attributes are used to configure Vagrant objects.
    #
    # @param identifier [Symbol]
    #
    # @return [Symbol] The identifier passed to `def_model_attribute`.
    def def_model_attribute(identifier)
      @model_attributes ||= []

      @model_attributes << identifier

      identifier
    end

    # Return all attributes defined for this model
    #
    # This method also returns inherited attributes.
    #
    # @return [Array<Symbol>] A list of model atttributes.
    def model_attributes
      @model_attributes ||= []

      if (self < ::ConfigBuilder::Model::Base)
        # This is a subclass of Model::Base
        superclass.model_attributes + @model_attributes
      else
        @model_attributes
      end
    end

    # Define a new model option
    #
    # Model options are used when building new Vagrant objects.
    #
    # @param identifier [Symbol]
    #
    # @since 0.16.0
    #
    # @return [Symbol] The identifier passed to `def_model_option`.
    def def_model_option(identifier)
      @model_options ||= []

      @model_options << identifier

      identifier
    end

    # Return all options defined for this model
    #
    # This method also returns inherited options.
    #
    # @since 0.16.0
    #
    # @return [Array<Symbol>] A list of model options.
    def model_options
      @model_options ||= []

      if (self < ::ConfigBuilder::Model::Base)
        # This is a subclass of Model::Base
        superclass.model_options + @model_options
      else
        @model_options
      end
    end
  end

  # Deserialize a hash into a configbuilder model
  #
  # @param attributes [Hash] The model attributes as represented in a hash.
  # @return [Object < ConfigBuilder::Model]
  def self.new_from_hash(attributes)
    obj = new()
    obj.attrs = attributes
    obj
  end

  # @api private
  def attrs=(config)
    hash = config.inject({}) { |hash, (key, value)| hash[key.to_sym] = value; hash }

    if @defaults
      @attrs = @defaults.merge(hash)
    else
      @attrs = hash
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
  # @param config [Vagrant.plugin('2', :config)]
  # @return [void]
  def call(config)
    to_proc.call(config)
  end

  # @param identifier [Symbol]
  #
  # @return [Object] The value of the model attribute specified by `identifier`
  #
  # @todo validate identifier
  def attr(identifier)
    @attrs[identifier]
  end

  # Conditionally evaluate a block with a model attribute if it's defined
  #
  # @since 0.6.0
  #
  # @param identifier [Symbol] The attribute identifier
  #
  # @return [void]
  def with_attr(identifier)
    val = @attrs[identifier]
    unless val.nil?
      yield val
    end
  end

  # Return the identifier value for this model instance
  #
  # @since 0.16.0
  #
  # @return [Object]
  def instance_id
    attr(self.class.model_id)
  end

  # Return a hash of all options which have been given a value
  #
  # This method returns a hash of options and their values. Options that were
  # not present in the data used to create a model instance will not be
  # returned.
  #
  # @since 0.16.0
  #
  # @return [Hash]
  def instance_options
    result = Hash.new

    self.class.model_options.each do |id|
      with_attr(id) {|val| result[id] = val}
    end

    result
  end

  # Copy attributes to a Vagrant configuration object
  #
  # This method iterates over each attribute defined via
  # #{.def_model_attribute} and copies data to a Vagrant configuration object.
  # By default, `config.attributename = value` is used. To provide custom
  # behavior, define a `configure_attributename` method. This method will be
  # passed the vagrant configuration object and the attribute value.
  #
  # @param [Vagrant.plugin('2', :config)] A Vagrant configuration object.
  #
  # @since 0.16.0
  #
  # @return [void]
  def configure!(config)
    self.class.model_attributes.each do |id|
      if self.respond_to?("configure_#{id}")
        # Call custom configuration method if defined.
        with_attr(id) {|val| send("configure_#{id}", config, val)}
      else
        # 99% of the time, it's just config.thing = val
        with_attr(id) {|val| config.send("#{id}=", val)}
      end
    end
  end
end
