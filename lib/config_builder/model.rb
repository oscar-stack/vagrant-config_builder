module ConfigBuilder

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
  # ## `#block`
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
  module Model
    require 'config_builder/model/synced_folder'
    require 'config_builder/model/vm'

    module Network
      require 'config_builder/model/network/forwarded_port'
      require 'config_builder/model/network/private_network'
    end

    module Provider
      require 'config_builder/model/provider/virtualbox'
    end

    module Provisioner
      require 'config_builder/model/provisioner/shell'
      require 'config_builder/model/provisioner/puppet'
      require 'config_builder/model/provisioner/puppet_server'
    end
  end
end
