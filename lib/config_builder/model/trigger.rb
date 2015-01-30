# Vagrant Trigger model
#
# @see https://github.com/emyl/vagrant-triggers
class ConfigBuilder::Model::Trigger < ConfigBuilder::Model::Base
  # @!attribute [rw] trigger
  #   @return [String] The name of the trigger (before, after, instead_of)
  def_model_attribute :trigger

  # @!attribute [rw] command
  #   @return [String] The vagrant command
  def_model_attribute :command

  # @!attribute [rw] host
  #   @return [Hash] The trigger options
  def_model_attribute :options

  # @!attribute [rw] script
  #   @return [String] The script
  def_model_attribute :script

  def to_proc
    script = attr(:script)
    Proc.new do |config|
      config.trigger.send(attr(:trigger).to_sym, attr(:command).to_sym, attr(:options)) do
        eval script
      end
    end
  end
end
