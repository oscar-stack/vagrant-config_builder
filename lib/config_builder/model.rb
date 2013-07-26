require 'vagrant/errors'
require 'config_builder/model_collection'

module ConfigBuilder

  module Model

    class UnknownAttributeError < Vagrant::Errors::VagrantError; end

    require 'config_builder/model/base'

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
