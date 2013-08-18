# The 'roles' filter adds a mechanism for defining generic VM roles and
# applying them to VMs.
#
# Defining roles
# --------------
#
# This filter adds support for a top level `roles` key. It contains a hash of
# role names that define a hash containing the role behavior.
#
# @note: The 'vms' field is of type Array, while the 'roles' field is of type
# Hash. This is because order of declaration matters for the actual VMs, while
# the order of declaration of roles does not matter.
#
# @example
#   >> run()
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

  # @!attribute [r] roles
  #   @return [Hash<String, Object>]
  attr_reader :roles

  def set_config(root_config)
    @root_config = root_config
    @roles       = @root_config.delete('roles')
    @vms         = @root_config.delete('vms')
  end

  def run
    return @root_config if @vms.nil?

    @root_config['vms'] = @vms.map { |vm_hash| filter_vm(vm_hash) }
    @root_config
  end

  # @param vm_hash [Hash]
  #
  # @return [Hash] The filtered VM
  def filter_vm(old_vm)
    role_list  = old_vm.delete('roles')
    node_stack = roles_by_name(role_list)

    node_stack << old_vm

    new_vm = node_stack.inject({}) do |accumulator, role|
      merge_nodes(accumulator, role)
    end

    new_vm
  end

  # Fetch the role associated with the given name
  #
  # @param role_name [String]
  #
  # @return [Hash<String, Object>]
  def role(name)
    if (retval = @roles[name])
      retval
    else
      raise ArgumentError, "Requested role #{name.inspect} is not defined, available roles: #{@roles.keys}."
    end
  end

  # @overload roles_by_name(name)
  #   @param name [String] A single role name
  #   @return [Array<Hash>] An array containing the requested role
  #
  # @overload roles_by_name(names)
  #   @param names [Array<String>] A list of role names
  #   @return [Array<Hash>] An array containing all of the requested roles in the
  #                         order requested.
  #
  # @overload roles_by_name(nothing)
  #   @param nothing [NilClass] nil
  #   @return [Array<>] An empty array
  #
  # @return [Array]
  def roles_by_name(field)

    case field
    when Array    then names = field
    when String   then names = [field]
    when NilClass then names = []
    end

    names.map { |name| role(name) }
  end

  private

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
