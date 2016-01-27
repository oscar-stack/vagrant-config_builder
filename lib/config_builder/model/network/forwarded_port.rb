# Vagrant forwarded port model
#
# @see http://docs.vagrantup.com/v2/networking/forwarded_ports.html
class ConfigBuilder::Model::Network::ForwardedPort < ConfigBuilder::Model::Base

  # @!attribute [rw] id
  #   @return [String, nil] An optional name used to identify this port forward
  def_model_attribute :id

  # @!attribute [rw] guest
  #   @return [Fixnum] The port on the guest that you want to be exposed on the
  #     host.
  def_model_attribute :guest

  # @!attribute [rw] guest_ip
  #   @return [String] The guest IP to bind the forwarded port to.
  def_model_attribute :guest_ip

  # @!attribute [rw] host
  #   @return [Fixnum] The port on the host that you want to use to access the
  #     port on the guest.
  def_model_attribute :host

  # @!attribute [rw] host_ip
  #   @return [String] The IP on the host you want to bind the forwarded port to.
  def_model_attribute :host_ip

  # @!attribute [rw] protocol
  #   @return [String] Either `udp` or `tcp`. This specifies the protocol that
  #     will be allowed through the forwarded port. By default this is "tcp".
  def_model_attribute :protocol

  # @!attribute [rw] auto_correct
  #   @return [Boolean] Whether to automatically correct port collisions
  def_model_attribute :auto_correct

  def initialize
    @defaults = {:auto_correct => false, :id => nil}
  end

  def to_proc
    Proc.new do |vm_config|
      vm_config.network(:forwarded_port, forwarded_port_opts)
    end
  end

  def forwarded_port_opts
    h = {}
    with_attr(:id)           { |val| h[:id]           = val }
    with_attr(:guest)        { |val| h[:guest]        = val }
    with_attr(:guest_ip)     { |val| h[:guest_ip]     = val }
    with_attr(:host)         { |val| h[:host]         = val }
    with_attr(:host_ip)      { |val| h[:host_ip]      = val }
    with_attr(:protocol)     { |val| h[:protocol]     = val }
    with_attr(:auto_correct) { |val| h[:auto_correct] = val }
    h
  end
end
