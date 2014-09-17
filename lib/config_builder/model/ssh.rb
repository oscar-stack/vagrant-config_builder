# Vagrant SSH credential model
#
# @see http://docs.vagrantup.com/v2/vagrantfile/ssh_settings.html
class ConfigBuilder::Model::SSH < ConfigBuilder::Model::Base
  # @!attribute [rw] username
  #   @return [String] This sets the username that Vagrant will SSH as by
  #     default. Providers are free to override this if they detect a more
  #     appropriate user. By default this is "vagrant," since that is what most
  #     public boxes are made as.
  def_model_attribute :username

  # @!attribute [rw] password
  #   @return [String] This sets a password that Vagrant will use to
  #     authenticate the SSH user. Note that Vagrant recommends you use
  #     key-based authentiation rather than a password (see #private_key_path)
  #     below. If you use a password, Vagrant will automatically insert a
  #     keypair if `insert_key` is true.
  def_model_attribute :password

  # @!attribute [rw] host
  #   @return [String] The hostname or IP to SSH into. By default this is
  #     empty, because the provider usually figures this out for you.
  def_model_attribute :host

  # @!attribute [rw] port
  #   @return [Fixnum] The port to SSH into. By default this is port 22.
  def_model_attribute :port

  # @!attribute [rw] guest_port
  #   @return [Fixnum] The port on the guest that SSH is running on. This is
  #     used by some providers to detect forwarded ports for SSH. For example,
  #     if this is set to 22 (the default), and Vagrant detects a forwarded
  #     port to port 22 on the guest from port 4567 on the host, Vagrant will
  #     attempt to use port 4567 to talk to the guest if there is no other
  #     option.
  def_model_attribute :guest_port

  # @!attribute [rw] private_key_path
  #   @return [String] The path to the private key to use to SSH into the guest
  #     machine. By default this is the insecure private key that ships with
  #     Vagrant, since that is what public boxes use. If you make your own
  #     custom box with a custom SSH key, this should point to that private
  #     key.
  #
  #     You can also specify multiple private keys by setting this to be an
  #     array. This is useful, for example, if you use the default private key
  #     to bootstrap the machine, but replace it with perhaps a more secure key
  #     later.
  def_model_attribute :private_key_path

  # @!attribute [rw] forward_agent
  #   @return [Boolean] If `true`, agent forwarding over SSH connections is
  #     enabled. Defaults to `false`.
  def_model_attribute :forward_agent

  # @!attribute [rw] forward_x11
  #   @return [Boolean] If `true`, X11 forwarding over SSH connections is
  #     enabled. Defaults to `false`.
  def_model_attribute :forward_x11

  # @!attribute [rw] insert_key
  #   @return [Boolean] If `true`, Vagrant will automatically insert an insecure
  #     keypair to use for SSH. By default, this is `true`. This only has an
  #     effect if you don't already use private keys for authentication.
  def_model_attribute :insert_key

  # @!attribute [rw] proxy_command
  #   @return [String] A command-line command to execute that receives the data
  #     to send to SSH on stdin. This can be used to proxy the SSH connection.
  #     `%h` in the command is replaced with the host and `%p` is replaced with
  #     the port.
  def_model_attribute :proxy_command

  # @!attribute [rw] pty
  #   @return [Boolean] If `true`, pty will be used for provisioning. Defaults
  #     to `false`.
  #
  #     This setting is an _advanced feature_ that should not be enabled unless
  #     absolutely necessary. It breaks some other features of Vagrant, and is
  #     really only exposed for cases where it is absolutely necessary. If you
  #     can find a way to not use a pty, that is recommended instead.
  def_model_attribute :pty

  # @!attribute [rw] shell
  #   @return [String] The shell to use when executing SSH commands from
  #     Vagrant. By default this is `bash -l`. Note that this has no effect on
  #     the shell you get when you run `vagrant ssh`. This configuration option
  #     only affects the shell to use when executing commands internally in
  #     Vagrant.
  def_model_attribute :shell

  def to_proc
    Proc.new do |global_config|
      ssh = global_config.ssh

      with_attr(:username)         { |val| ssh.username = val }
      with_attr(:password)         { |val| ssh.password = val }
      with_attr(:host)             { |val| ssh.host = val }
      with_attr(:port)             { |val| ssh.port = val }
      with_attr(:guest_port)       { |val| ssh.guest_port = val }
      with_attr(:private_key_path) { |val| ssh.private_key_path = val }
      with_attr(:forward_agent)    { |val| ssh.forward_agent = val }
      with_attr(:forward_x11)      { |val| ssh.forward_x11 = val }
      with_attr(:insert_key)       { |val| ssh.insert_key = val }
      with_attr(:proxy_command)    { |val| ssh.proxy_command = val }
      with_attr(:pty)              { |val| ssh.pty = val }
      with_attr(:shell)            { |val| ssh.shell = val }
    end
  end
end
