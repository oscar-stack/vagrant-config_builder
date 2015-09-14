$LOAD_PATH << File.expand_path(File.join('..', 'lib'), __FILE__)
require 'config_builder/version'

Gem::Specification.new do |gem|
  gem.name    = 'vagrant-config_builder'
  gem.version = ConfigBuilder::VERSION

  gem.summary     = 'Generate Vagrant configurations from arbitrary data'

  gem.authors  = 'Adrien Thebo'
  gem.email    = 'adrien@somethingsinistral.net'
  gem.homepage = 'https://github.com/adrienthebo/vagrant-config_builder'

  gem.has_rdoc = true
  gem.license  = 'Apache 2.0'

  gem.files        = %x{git ls-files -z}.split("\0")
  gem.require_path = 'lib'

  gem.add_runtime_dependency 'deep_merge', '~> 1.0.0'

  # Pin to 2.14.x for compatibility with vagrant-spec.
  gem.add_development_dependency 'rspec', '~> 2.14.0'
end
