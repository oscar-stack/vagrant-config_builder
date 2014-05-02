require 'vagrant/errors'
require 'config_builder/class_registry'
require 'config_builder/model_delegator'

module ConfigBuilder

  module Model

    require 'config_builder/model/base'

    require 'config_builder/model/root'

    require 'config_builder/model/ssh'
    #require 'config_builder/model/host'

    require 'config_builder/model/vm'
    require 'config_builder/model/synced_folder'

    def self.generate(hash)
      ConfigBuilder::Model::Root.new_from_hash(hash)
    end

    module Network
      require 'config_builder/model/network/forwarded_port'
      require 'config_builder/model/network/private_network'
    end

    module Provider

      @registry = ConfigBuilder::ClassRegistry.new(:provider)

      def self.new_from_hash(hash)
        @registry.generate(hash)
      end

      def self.register(name, klass)
        @registry.register(name, klass)
      end

      require 'config_builder/model/provider/virtualbox'
      require 'config_builder/model/provider/vmware_fusion'
    end

    module Provisioner

      @registry = ConfigBuilder::ClassRegistry.new(:provisioner)

      def self.new_from_hash(hash)
        @registry.generate(hash)
      end

      def self.register(name, klass)
        @registry.register(name, klass)
      end

      require 'config_builder/model/provisioner/shell'
      require 'config_builder/model/provisioner/puppet'
      require 'config_builder/model/provisioner/puppet_server'
    end
  end
end
