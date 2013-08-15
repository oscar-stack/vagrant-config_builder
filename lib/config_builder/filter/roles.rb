# The 'roles' filter adds a mechanism for defining generic VM roles and
# applying them to VMs.
#
# @example
#   >> hash_config
#   =>  {
#         'roles' => {
#           'webserver' => {
#             'synced_folders' => [
#               {'host_path' => './www',                'guest_path' => '/var/www'},
#               {'host_path' => './webserver-binaries', 'guest_path' => '/opt/webserver-binaries'},
#             ]
#           },
#           'database' => {
#             'provisioners' => [
#               {'type' => 'puppet', 'manifest' => 'dbserver.pp'},
#               {'type' => 'shell',  'path'     => 'scripts/initialize-db.sh'},
#             ],
#           }
#         },
#         'vms' => [
#           {'name' => 'web',        'roles' => 'webserver'},
#           {'name' => 'db',         'roles' => 'database'},
#           {'name' => 'standalone', 'roles' => ['webserver', 'database']},
#         ],
#       }
#
class ConfigBuilder::Filter::Roles

  def run(hash_config)
    @roles = hash_config.delete('roles')

    hash_config['vms'].map! { |vm_hash| filter_vm(vm_hash) }

    hash_config
  end

  private

  def filter_vm(old_vm)
    role_list  = old_vm.delete('roles')
    node_stack = roles_for_vm(role_list)

    node_stack << old_vm

    new_vm = node_stack.inject({}) do |accumulator, role|
      merge_nodes(accumulator, role)
    end

    new_vm
  end

  # @return [Array]
  def roles_for_vm(role_field)

    case role_field
    when Array    then names = role_field
    when String   then names = [role_field]
    when NilClass then names = []
    end

    names.map { |name| role_definition(name) }
  end

  def role_definition(name)
    if (defn = @roles[name])
      defn
    else
      raise "Couldn't find role named #{name.inspect} in roles #{@roles.keys.inspect}"
    end
  end

  # Merge two node hash structures, with values in `right` overwriting values
  # in `left`.
  #
  # @param left  [Hash]
  # @param right [Hash]
  #
  # @return [Hash]
  def merge_nodes(left, right)
    retval = right.clone

    array_keys = %w[
      provisioners
      synced_folders
      forwarded_ports
      private_networks
      public_networks
    ]

    array_keys.each do |key|
      if (left[key] and right[key])
        retval[key] += left[key]
      elsif left[key]
        retval[key] = left[key]
      end
    end

    single_keys = %w[provider box name]

    single_keys.each do |key|
      retval[key] = left[key] if left[key]
    end

    retval
  end
end
