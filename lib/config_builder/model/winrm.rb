# Vagrant WinRM credential model.
#
# @see http://docs.vagrantup.com/v2/vagrantfile
class ConfigBuilder::Model::WinRM < ConfigBuilder::Model::Base

  attr_accessor :username
  attr_accessor :password
  attr_accessor :host
  attr_accessor :port
  attr_accessor :guest_port
  attr_accessor :max_tries
  attr_accessor :timeout

  # @!attribute [rw] username
  #   @return [String] This sets the username that Vagrant will WinRM as by default. Providers are free to override
  #   this if they detect a more appropriate user. By default this is "vagrant," since that is what most public boxes
  #   are made as.
  def_model_attribute :username

  # @!attribute [rw] password
  #   @return [String] This sets a password that Vagrant will use to authenticate the WinRM user.
  def_model_attribute :password

  # @!attribute [rw] host
  #   The hostname or IP to WinRM into. By default this is empty, because the provider usually figures this out for you.
  #   @return [String]
  def_model_attribute :host

  # @!attribute [rw] port
  #   @return [Fixnum] The port to WinRM into. By default this is port 5985.
  def_model_attribute :port

  # @!attribute [rw] guest_port
  #   @return [Fixnum] The port on the guest that WinRM is running on.
  #   This is used by some providers to detect forwarded ports for WinRM.
  #   For example, if this is set to 5985 (the default), and Vagrant detects a forwarded port to port 5985 on the
  #   guest from port 4567 on the host, Vagrant will attempt to use port 4567 to talk to the guest if there is no
  #   other option.
  def_model_attribute :guest_port

  # @!attribute [rw] max_tries
  #   @return [Fixnum] Maximum number of retry attempts.  By default this is 20.
  def_model_attribute :max_tries

  # @!attribute [rw] timeout
  #   @return [Fixnum] The timeout in seconds.  By default this is 1800 seconds.
  def_model_attribute :timeout

  def initialize
    unset_value = Vagrant::Plugin::V2::Config::UNSET_VALUE
    @defaults = {
      :username     => unset_value,
      :password     => unset_value,
      :host         => unset_value,
      :port         => unset_value,
      :guest_port   => unset_value,
      :max_tries    => unset_value,
      :timeout      => unset_value,
    }
  end

  def to_proc
    Proc.new do |global_config|
      winrm = global_config.winrm

      winrm.username    = attr(:username)
      winrm.password    = attr(:password)
      winrm.host        = attr(:host)
      winrm.port        = attr(:port)
      winrm.guest_port  = attr(:guest_port)
      winrm.max_tries   = attr(:max_tries)
      winrm.timeout     = attr(:timeout)
    end
  end
end
