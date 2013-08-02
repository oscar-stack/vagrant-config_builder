require 'vagrant'

module ConfigBuilder
  require 'config_builder/loader'
  require 'config_builder/model'
  require 'config_builder/runner'
  require 'config_builder/plugin'
  require 'config_builder/version'

  def self.load(identifier, method, value)
    runner = ConfigBuilder::Runner.new
    runner.run(identifier, method, value)
  end
end
