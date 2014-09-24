class ConfigBuilder::Model::Provider::VMwareFusion < ConfigBuilder::Model::Provider::VMware
  def initialize
    @providers = %w[vmware_fusion]
    super
  end

  ConfigBuilder::Model::Provider.register('vmware_fusion', self)
end
