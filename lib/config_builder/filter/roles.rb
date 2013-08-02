class ConfigBuilder::Filter::Roles

  def run(input)
    strip_filter_data(input)

    vms = @vms.map { |vm_hash| filter_vm(vm_hash) }

    add_filtered_data(input, vms)

    input
  end

  private

  def strip_filter_data(input)
    @roles = input.delete('roles')
    @vms   = input.delete('vms')
  end

  def add_filtered_data(input, vms)
    input['vms'] = vms
  end

  def filter_vm(vm_hash)
    role_names = roles_for_vm(vm_hash.delete('roles'))

    new_vm_hash = merge_role_definitions(role_names)
    new_vm_hash.merge!(vm_hash)

    new_vm_hash
  end

  # Generate a hash of all the merged roles. Roles specified later in the hash
  # overwrite earlier roles.
  #
  # @param names [Hash]
  #
  # @return [Hash]
  def merge_role_definitions(role_names)
    vm_template = {}

    role_names.each do |name|
      role_definition = @roles[name]
      template.merge!(role_definition)
    end

    vm_template
  end

  # @return [Array]
  def roles_for_vm(role_field)
    case role_field
    when Array
      rval = role_field
    when String
      rval = [role_field]
    when NilClass
      rval = []
    end

    rval
  end

  def role_definition(name)
    if (defn = @roles[name])
      defn
    else
      raise "Couldn't find role named #{name.inspect} in roles #{@roles.keys.inspect}"
    end
  end
end
