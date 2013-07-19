class ConfigBuilder::Model::Provider::Virtualbox

  # @!attribute [rw] name
  #   @return [String] The name of the created VM in the Virtualbox GUI
  attr_accessor :name

  # @!attribute [rw] customize
  #   @return [Array<String>] A list of customize arguments to use upon VM instantiation.
  attr_accessor :customize

end
