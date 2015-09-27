require 'vagrant'
require 'log4r'

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

  def self.logger
    @logger ||= setup_logger
  end

  def self.source_root
    @source_root ||= File.expand_path('..', __FILE__)
  end

  def self.template_root
    @template_root ||= File.expand_path('../templates', source_root)
  end

  def self.setup_logger
    logger = Log4r::Logger.new('config_builder')
    logger.outputters = Log4r::Outputter.stderr

    logger
  end
  private_class_method :setup_logger
end

I18n.load_path << File.join(ConfigBuilder.template_root, 'locales/en.yml')
