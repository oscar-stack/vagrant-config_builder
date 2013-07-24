# Vagrant shared folder model.
#
# @see http://docs.vagrantup.com/v2/synced-folders/index.html
class ConfigBuilder::Model::SyncedFolder

  # @!attribute [rw] host_path
  #   @return [String] The host file path to mount on the guest
  attr_accessor :host_path

  # @!attribute [rw] guest_path
  #   @return [String] The guest file path to be used as the mount point
  attr_accessor :guest_path

  # @!attribute [rw] extra
  #   A set of arbitrary options to pass to the virtualbox mount command.
  #   @return [String]
  attr_accessor :extra

  # @!attribute [rw] disabled
  #   @return [Boolean] If the mount point should be disabled.
  attr_accessor :disabled

  # @!attribute [rw] nfs
  #   @return [Boolean] If the mount point should use NFS
  attr_accessor :nfs

  def to_proc
    Proc.new do |config|
      config.synced_folder(@host_path, @guest_path, folder_opts)
    end
  end

  private

  def folder_opts
    h = {}
    h[:extra]    = @extra    if defined? @extra
    h[:disabled] = @disabled if defined? @disabled
    h[:nfs]      = @nfs      if defined? @nfs

    h
  end
end
