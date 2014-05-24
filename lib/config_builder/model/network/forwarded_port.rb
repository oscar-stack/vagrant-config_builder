# Vagrant forwarded port model
#
# @see http://docs.vagrantup.com/v2/networking/forwarded_ports.html
class ConfigBuilder::Model::Network::ForwardedPort < ConfigBuilder::Model::Base

  # @!attribute [rw] guest
  #   @return [Fixnum] The guest port
  def_model_attribute :guest

  # @!attribute [rw] host
  #   @return [Fixnum] The host port
  def_model_attribute :host

  # @!attribute [rw] auto_correct
  #   @return [Boolean] Whether to automatically correct port collisions
  def_model_attribute :auto_correct

  # @!attribute [rw] id
  #   @return [String, nil] An optional name used to identify this port forward
  def_model_attribute :id

  def initialize
    @defaults = {:auto_correct => false, :id => nil}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.network(
        :forwarded_port,
        :guest        => attr(:guest),
        :host         => attr(:host),
        :auto_correct => attr(:auto_correct),
        :id           => attr(:id),
      )
    end
  end
end
