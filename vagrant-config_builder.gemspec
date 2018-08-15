$LOAD_PATH << File.expand_path(File.join('..', 'lib'), __FILE__)
require 'config_builder/version'

Gem::Specification.new do |gem|
  gem.name    = 'vagrant-config_builder'
  gem.version = ConfigBuilder::VERSION

  gem.summary     = 'Generate Vagrant configurations from arbitrary data'

  gem.authors  = ['Adrien Thebo', 'Charlie Sharpsteen']
  gem.email    = ['adrien@somethingsinistral.net', 'source@sharpsteen.net']
  gem.homepage = 'https://github.com/oscar-stack/vagrant-config_builder'

  gem.has_rdoc = true
  gem.license  = 'Apache 2.0'

  gem.files        = %x{git ls-files -z}.split("\0")
  gem.require_path = 'lib'

  gem.add_runtime_dependency 'deep_merge', '~> 1.0'

  # Pinned for compatibility with vagrant-spec.
  gem.add_development_dependency 'rake', '~> 10.0'
end
