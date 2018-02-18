require 'vagrant'

require 'config_builder/action/load_extensions'

module VagrantPlugins
  module ConfigBuilder
    class Plugin < Vagrant.plugin('2')
      name "Generate Vagrant configuration from logic-less data sources"

      action_hook('ConfigBuilder: load extensions', :environment_load) do |hook|
        hook.prepend(::ConfigBuilder::Action::LoadExtensions)
      end

      # Internal action hooks
      action_hook('Vagrant Config Builder: vagrant version check', :environment_load) do |hook|
        require 'config_builder/action/version_check'
        hook.prepend(::ConfigBuilder::Action::VersionCheck)
      end
    end
  end
end
