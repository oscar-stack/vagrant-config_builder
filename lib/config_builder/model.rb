require 'vagrant/errors'
require 'config_builder/model_collection'
require 'config_builder/model_delegator'

module ConfigBuilder

  module Model

    class UnknownAttributeError < Vagrant::Errors::VagrantError; end

    require 'config_builder/model/base'

    require 'config_builder/model/root'

    require 'config_builder/model/ssh'
    #require 'config_builder/model/host'

    require 'config_builder/model/vm'
    require 'config_builder/model/synced_folder'

    module Network
      require 'config_builder/model/network/forwarded_port'
      require 'config_builder/model/network/private_network'
    end

    module Provider

      @collection = ConfigBuilder::ModelCollection.new(:provider)

      def self.new_from_hash(hash)
        @collection.generate(hash)
      end

      def self.register(name, klass)
        @collection.register(name, klass)
      end

      require 'config_builder/model/provider/virtualbox'
    end

    module Provisioner

      @collection = ConfigBuilder::ModelCollection.new(:provisioner)

      def self.new_from_hash(hash)
        @collection.generate(hash)
      end

      def self.register(name, klass)
        @collection.register(name, klass)
      end

      require 'config_builder/model/provisioner/shell'
      require 'config_builder/model/provisioner/puppet'
      require 'config_builder/model/provisioner/puppet_server'
    end
  end
end
