# @see http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html
class ConfigBuilder::Model::SSH < ConfigBuilder::Model::Base
  # @!attribute [rw] guest_port
  # @!attribute [rw] keepalive
  # @!attribute [rw] max_tries
  # @!attribute [rw] timeout
  # @!attribute [rw] forward_x11
  # @!attribute [rw] forward_agent
  # @!attribute [rw] shell
end
