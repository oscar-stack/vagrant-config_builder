# Vagrant NFS model
#
# @see https://docs.vagrantup.com/v2/synced-folders/nfs.html
class ConfigBuilder::Model::NFS < ConfigBuilder::Model::Base
  # @!attribute [rw] functional
  #   @return [Boolean] If false, then NFS will not be used as a synced folder
  #     type.
  def_model_attribute :functional

  # @!attribute [rw] map_uid
  #   @return [Fixnum] The UID to map all read/write requests to.
  def_model_attribute :map_uid

  # @!attribute [rw] map_gid
  #   @return [Fixnum] The GID to map all read/write requests to.
  def_model_attribute :map_gid

  # @!attribute [rw] verify_installed
  #   @return [Boolean] If this is false, then Vagrant will skip checking if NFS
  #     is installed.
  def_model_attribute :verify_installed

  def to_proc
    Proc.new do |global_config|
      nfs = global_config.nfs

      with_attr(:functional)       { |val| nfs.functional       = val }
      with_attr(:map_uid)          { |val| nfs.map_uid          = val }
      with_attr(:map_gid)          { |val| nfs.map_gid          = val }
      with_attr(:verify_installed) { |val| nfs.verify_installed = val }
    end
  end
end
