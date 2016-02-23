# @see http://docs.vagrantup.com/v2/provisioning/file.html
class ConfigBuilder::Model::Provisioner::File < ConfigBuilder::Model::Provisioner::Base
  # @!attribute [rw] source
  #   @return [Source] Is the local path of the file to be uploaded.
  def_model_attribute :source

  # @!attribute [rw] destination
  #   @return [Source] Is the remote path on the guest machine where the file
  #     will be uploaded to. The file is uploaded as the SSH user over SCP, so
  #     this location must be writable to that user. The SSH user can be
  #     determined by running vagrant ssh-config, and defaults to "vagrant".
  def_model_attribute :destination

  ConfigBuilder::Model::Provisioner.register('file', self)
end
