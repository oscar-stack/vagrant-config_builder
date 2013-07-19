require 'activemodel'

# Vagrant shared folder model.
#
# @see http://docs.vagrantup.com/v2/synced-folders/index.html
class ConfigBuilder::Model::SyncedFolder
  include ActiveModel::Validations

  attr_accessor :host_path
  validates_presence_of :host_path

  attr_accessor :guest_path
  validates_presence_of :guest_path

  # @!attribute [rw] extra
  #   A set of arbitrary options to pass to the virtualbox mount command.
  #   @return [String]
  attr_accessor :extra

  # @!attribute [rw] disabled
  #   @return [Boolean] If the mount point should be disabled.
  attr_accessor :disabled
end
