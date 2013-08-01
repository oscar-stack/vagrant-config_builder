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

  # @!attribute [rw] extra
  #   A set of arbitrary options to pass to the virtualbox mount command.
  #   @return [String]
  def_model_attribute :extra

  # @!attribute [rw] disabled
  #   @return [Boolean] If the mount point should be disabled.
  def_model_attribute :disabled

  # @!attribute [rw] nfs
  #   @return [Boolean] If the mount point should use NFS
  def_model_attribute :nfs

  def to_proc
    Proc.new do |vm_config|
      vm_config.synced_folder(attr(:host_path), attr(:guest_path), folder_opts)
    end
  end

  private

  def folder_opts
    h = {}
    h[:extra]    = attr(:extra)    if attr(:extra)
    h[:disabled] = attr(:disabled) if attr(:disabled)
    h[:nfs]      = attr(:nfs)      if attr(:nfs)

    h
  end
end
