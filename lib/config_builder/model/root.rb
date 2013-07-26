# Model the root level Vagrant config object
#
# @see http://docs.vagrantup.com/v2/vagrantfile/index.html
class ConfigBuilder::Model::Root < ConfigBuilder::Model::Base
  attr_accessor :host
  attr_accessor :ssh
  attr_accessor :vms
end
