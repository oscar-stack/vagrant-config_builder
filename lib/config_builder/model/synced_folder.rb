# Vagrant shared folder model.
#
# @see http://docs.vagrantup.com/v2/synced-folders/index.html
class ConfigBuilder::Model::SyncedFolder < ConfigBuilder::Model::Base

  # @!attribute [rw] host_path
  #   @return [String] The host file path to mount on the guest
  def_model_attribute :host_path

  # @!attribute [rw] guest_path
  #   @return [String] The guest file path to be used as the mount point
  def_model_attribute :guest_path

  # @!attribute [rw] create
  #   @return [Boolean] If true, the host path will be created if it does not exist
  def_model_attribute :create

  # @!attribute [rw] extra
  #   A set of arbitrary options to pass to the virtualbox mount command.
  #   @return [String]
  def_model_attribute :extra

  # @!attribute [rw] disabled
  #   @return [Boolean] If the mount point should be disabled.
  def_model_attribute :disabled

  # @!attribute [rw] group
  #   @return [String] The group that will own the synced folder. By default this will be the SSH user
  def_model_attribute :group

  # @!attribute [rw] nfs
  #   @return [Boolean] If the mount point should use NFS
  def_model_attribute :nfs

  # @!attribute [rw] owner
  #   @return [String] The user who should be the owner of this synced folder. By default this will be the SSH user
  def_model_attribute :owner

  # @!attribute [rw] type
  #   @return [String] The method for syncing folder to guest.
  def_model_attribute :type

  def to_proc
    Proc.new do |vm_config|
      vm_config.synced_folder(attr(:host_path), attr(:guest_path), folder_opts)
    end
  end

  private

  def folder_opts
    h = {}
    with_attr(:create)  { |val| h[:create]   = val }
    with_attr(:extra)   { |val| h[:extra]    = val }
    with_attr(:disabled) { |val| h[:disabled] = val }
    with_attr(:group)   { |val| h[:group]    = val }
    with_attr(:nfs)     { |val| h[:nfs]      = val }
    with_attr(:owner)   { |val| h[:owner]    = val }
    with_attr(:type)    { |val| h[:type]     = val }

    h
  end
end
