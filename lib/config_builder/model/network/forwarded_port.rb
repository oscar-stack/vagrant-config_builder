# Vagrant forwarded port model
#
# @see http://docs.vagrantup.com/v2/networking/forwarded_ports.html
class ConfigBuilder::Model::Network::ForwardedPort

  # @!attribute [rw] guest
  #   @return [Fixnum] The guest port
  attr_accessor :guest

  # @!attribute [rw] host
  #   @return [Fixnum] The host port
  attr_accessor :host

  # @!attribute [rw] auto_correct
  #   @return [Boolean] Whether to automatically correct port collisions
  attr_accessor :auto_correct
end
