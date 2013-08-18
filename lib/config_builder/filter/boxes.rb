class ConfigBuilder::Filter::Boxes

  attr_reader :boxes

  def set_config(root_config)
    @root_config = root_config
    @boxes       = (@root_config.delete('boxes') || {})
  end

  def run
    return @root_config if @root_config['vms'].nil?

    @root_config['vms'].each { |vm_hash| filter_vm(vm_hash) }
    @root_config
  end

  def filter_vm(vm_hash)
    if (box_name = vm_hash['box'])
      vm_hash['box_url'] ||= @boxes[box_name]
    end
  end
end
