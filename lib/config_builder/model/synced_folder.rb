# Vagrant shared folder model.
#
# @see http://docs.vagrantup.com/v2/synced-folders/index.html
class ConfigBuilder::Model::SyncedFolder < ConfigBuilder::Model::Base

  # @!attribute [rw] host_path
  #   @return [String] The host file path to mount on the guest.
  def_model_attribute :host_path

  # @!attribute [rw] guest_path
  #   @return [String] The guest file path to be used as the mount point.
  def_model_attribute :guest_path

  # @!attribute [rw] create
  #   @return [Boolean] If true, the host path will be created if it does not
  #     exist.
  def_model_attribute :create

  # @!attribute [rw] mount_options
  #   @return [Array<String>] A list of additional options to pass to the mount.
  #     command.
  def_model_attribute :mount_options

  # @!attribute [rw] disabled
  #   @return [Boolean] If the mount point should be disabled.
  def_model_attribute :disabled

  # @!attribute [rw] group
  #   @return [String] The group that will own the synced folder. By default this
  #     will be the SSH user.
  def_model_attribute :group

  # @!attribute [rw] owner
  #   @return [String] The user who should be the owner of this synced folder. By
  #     default this will be the SSH user.
  def_model_attribute :owner

  # @!attribute [rw] type
  #   @return [String] The method for syncing folder to guest.
  def_model_attribute :type

  # @!attribute [rw] nfs_export
  #   @return [Boolean] Whether Vagrant should manage entries in /etc/exports.
  def_model_attribute :nfs_export

  # @!attribute [rw] nfs_export
  #   @return [nfs_udp] Whether or not to use UDP as the transport.
  def_model_attribute :nfs_udp

  # @!attribute [rw] nfs_version
  #   @return [Fixnum, String] The NFS protocol version to use.
  def_model_attribute :nfs_version

  # @!attribute [rw] rsync__args
  #   @return [Array<String>] A list of arguments to supply to rsync.
  def_model_attribute :rsync__args

  # @!attribute [rw] rsync__auto
  #   @return [Boolean] If false, then rsync-auto will not watch and
# automatically sync this folder.
  def_model_attribute :rsync__auto

  # @!attribute [rw] rsync__chown
  #   @return [Boolean] If false, then the owner and group options for the synced
  #     folder are ignored and Vagrant will not execute a recursive chown.
  def_model_attribute :rsync__chown

  # @!attribute [rw] rsync__exclude
  #   @return [String, Array<String>] A list of files or directories to exclude
  #     from the sync.
  def_model_attribute :rsync__exclude

  # @!attribute [rw] rsync__rsync_path
  #   @return [String] The path on the remote host where rsync is and how it is
# executed.
  def_model_attribute :rsync__rsync_path

  # @!attribute [rw] rsync__verbose
  #   @return [Boolean] If true, then the output from the rsync process will be
  #     echoed to the console.
  def_model_attribute :rsync__verbose

  def to_proc
    Proc.new do |vm_config|
      vm_config.synced_folder(attr(:host_path), attr(:guest_path), folder_opts)
    end
  end

  private

  def folder_opts
    h = {}
    with_attr(:create)            { |val| h[:create]            = val }
    with_attr(:mount_options)     { |val| h[:mount_options]     = val }
    with_attr(:disabled)          { |val| h[:disabled]          = val }
    with_attr(:group)             { |val| h[:group]             = val }
    with_attr(:create)            { |val| h[:create]            = val }
    with_attr(:extra)             { |val| h[:extra]             = val }
    with_attr(:disabled)          { |val| h[:disabled]          = val }
    with_attr(:group)             { |val| h[:group]             = val }
    with_attr(:nfs)               { |val| h[:nfs]               = val }
    with_attr(:owner)             { |val| h[:owner]             = val }
    with_attr(:type)              { |val| h[:type]              = val }
    # NFS
    with_attr(:nfs_export)        { |val| h[:nfs_export]        = val }
    with_attr(:nfs_udp)           { |val| h[:nfs_udp]           = val }
    with_attr(:nfs_version)       { |val| h[:nfs_version]       = val }
    # RSync
    with_attr(:rsync__args)       { |val| h[:rsync__args]       = val }
    with_attr(:rsync__auto)       { |val| h[:rsync__auto]       = val }
    with_attr(:rsync__chown)      { |val| h[:rsync__chown]      = val }
    with_attr(:rsync__exclude)    { |val| h[:rsync__exclude]    = val }
    with_attr(:rsync__rsync_path) { |val| h[:rsync__rsync_path] = val }
    with_attr(:rsync__verbose)    { |val| h[:rsync__verbose]    = val }
    h
  end
end
