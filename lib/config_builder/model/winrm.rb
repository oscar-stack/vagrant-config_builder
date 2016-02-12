# Vagrant WinRM credential model.
#
# @see http://docs.vagrantup.com/v2/vagrantfile
class ConfigBuilder::Model::WinRM < ConfigBuilder::Model::Base
  # @!attribute [rw] username
  #   @return [String] This sets the username that Vagrant will WinRM as by
  #     default. Providers are free to override this if they detect a more
  #     appropriate user. By default this is "vagrant," since that is what most
  #     public boxes are made as.
  def_model_attribute :username

  # @!attribute [rw] password
  #   @return [String] This sets a password that Vagrant will use to
  #     authenticate the WinRM user.
  def_model_attribute :password

  # @!attribute [rw] host
  #   @return [String] The hostname or IP to WinRM into. By default this is
  #     empty, because the provider usually figures this out for you.
  def_model_attribute :host

  # @!attribute [rw] port
  #   @return [Fixnum] The port to WinRM into. By default this is port 5985.
  def_model_attribute :port

  # @!attribute [rw] guest_port
  #   @return [Fixnum] The port on the guest that WinRM is running on.
  #     This is used by some providers to detect forwarded ports for WinRM.
  #     For example, if this is set to 5985 (the default), and Vagrant detects
  #     a forwarded port to port 5985 on the guest from port 4567 on the host,
  #     Vagrant will attempt to use port 4567 to talk to the guest if there is
  #     no other option.
  def_model_attribute :guest_port

  # @!attribute [rw] max_tries
  #   @return [Fixnum] Maximum number of retry attempts.  By default this is 20.
  def_model_attribute :max_tries

  # @!attribute [rw] retry_delay
  #   @return [Fixnum]
  def_model_attribute :retry_delay

  # @!attribute [rw] timeout
  #   @return [Fixnum] The timeout in seconds.  By default this is 1800 seconds.
  def_model_attribute :timeout

  # @!attribute [rw] transport
  #   @return [String, Symbol]
  def_model_attribute :transport
  
  # @!attribute [rw] ssl_peer_verification
  #   @return [Boolean]
  def_model_attribute :ssl_peer_verification

  # @!attribute [rw] execution_time_limit
  #   @return [String]
  def_model_attribute :execution_time_limit

  def to_proc
    Proc.new do |global_config|
      winrm = global_config.winrm

      with_attr(:username)              { |val| winrm.username              = val }
      with_attr(:password)              { |val| winrm.password              = val }
      with_attr(:host)                  { |val| winrm.host                  = val }
      with_attr(:guest)                 { |val| winrm.guest                 = val }
      with_attr(:guest_port)            { |val| winrm.guest_port            = val }
      with_attr(:max_tries)             { |val| winrm.max_tries             = val }
      with_attr(:retry_delay)           { |val| winrm.retry_delay           = val }
      with_attr(:timeout)               { |val| winrm.timeout               = val }
      with_attr(:transport)             { |val| winrm.transport             = val.to_sym }
      with_attr(:ssl_peer_verification) { |val| winrm.ssl_peer_verification = val }
      with_attr(:execution_time_limit)  { |val| winrm.execution_time_limit  = val }
    end
  end
end
