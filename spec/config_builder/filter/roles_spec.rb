require 'spec_helper'

describe ConfigBuilder::Filter::Roles do

  def dup(o)
    Marshal.load(Marshal.dump(o))
  end

  let(:roles) do
    {
      'shell-provisioner' => {
        'provisioners' => [
          {'type' => 'shell', 'inline' => '/usr/bin/sl'},
        ],
      },
      'puppet-provisioner' => {
        'provisioners' => [
          {'type' => 'puppet', 'manifest' => 'sl.pp'},
          {'type' => 'puppet', 'manifest' => 'starwars.pp'},
        ],
      },
      'potato-provisioner' => {
        'provisioners' => [
          {'type' => 'potato', 'potato' => 'POHTAHTO.pp'},
        ],
      },
      'folders-12' => {
        'synced_folders' => [
          {'guest_path' => '/guest-1', 'host_path' => './host-1'},
          {'guest_path' => '/guest-2', 'host_path' => './host-2'},
        ],
      },
      'folders-34' => {
        'synced_folders' => [
          {'guest_path' => '/guest-3', 'host_path' => './host-3'},
          {'guest_path' => '/guest-4', 'host_path' => './host-4'},
        ],
      },
      'shared-networks' => {
        'private_networks' => [
          {'ip' => '1.2.3.4'}
        ]
      },
      'windows' => {
        'communicator' => 'winrm',
      },
    }
  end

  let(:vms) do
    [
      {'name'  => 'master'},
      {'name'  => 'debian-6-agent'},
    ]
  end


  describe "without a top level roles key" do

    let(:config) do
      {'vms' => vms}
    end

    before do
      subject.set_config(dup(config))
    end

    it "doesn't alter the structure" do
      input  = dup(config)
      output = subject.run

      expect(output).to eq config
    end
  end

  describe 'loading configured roles' do
    let(:config) do
      {
        'vms' => [{'name' => 'master'}],
        'roles' => roles,
      }
    end

    before do
      subject.set_config(dup(config))
    end

    it 'strips out the roles from top-level configuration' do
      output = subject.run
      expect(output).to_not have_key 'roles'
    end
  end

  describe 'operating on a single vm' do
    let(:vms) do
      [{
        'name'  => 'master',
        'foo'   => 'bar',
        'roles' => [ 'shell-provisioner', 'folders-12' ],
      }]
    end

    let(:config) do
      {
        'vms'   => vms,
        'roles' => roles,
      }
    end

    let(:filtered_vm) do
      output = subject.run
      output['vms'][0]
    end

    before do
      subject.set_config(dup(config))
    end

    it "removes the 'roles' key if present" do
      expect(filtered_vm).to_not have_key 'roles'
    end

    it 'preserves top-level configuration' do
      expect(filtered_vm).to have_key 'foo'
    end

    context 'with no roles' do
      let(:vms) { [{'name' => 'master'}] }

      it "doesn't alter the vm" do
        output = subject.run
        expect(output['vms']).to eq vms
      end
    end

    context 'with roles set to a single string' do
      let(:vms) { [{'name' => 'master', 'roles' => 'shell-provisioner'}] }

      it 'applies the role' do
        expected = [{
          'type'   => 'shell',
          'inline' => '/usr/bin/sl',
        }]

        expect(filtered_vm['provisioners']).to eq expected
      end
    end

    context 'with roles set to an array' do
      let(:vms) do
        [{
          'name'  => 'master',
          'roles' => [
            'folders-12',
            'puppet-provisioner',
            'shell-provisioner',
          ]
        }]
      end

      it 'applies all of the roles' do
        expect(filtered_vm).to have_key 'provisioners'
        expect(filtered_vm).to have_key 'synced_folders'
      end

      it 'merges attribute arrays in reverse order' do
        expected_prov = [
          {'type'   => 'shell', 'inline' => '/usr/bin/sl'},
          {'type' => 'puppet', 'manifest' => 'sl.pp'},
          {'type' => 'puppet', 'manifest' => 'starwars.pp'},
        ]

        expect(filtered_vm['provisioners']).to eq expected_prov
      end
    end

    context 'when vm configuration overlaps with roles' do
      let(:vms) do
        [{
          'name'         => 'master',
          'roles'        => [ 'shell-provisioner', 'windows' ],
          'communicator' => 'ssh',
          'provisioners' => [
            {'type' => 'foo', 'parameter' => 'bar', }
          ],
        }]
      end

      it 'preserves single_keys set on the vm' do
        expect(filtered_vm['communicator']).to eq 'ssh'
      end

      it 'merges array_keys set on the vm last' do
        expected_prov = {
          'type'      => 'foo',
          'parameter' => 'bar',
        }

        expect(filtered_vm['provisioners'].last).to eq expected_prov
      end
    end

  end

  describe "with multiple VMs and shared roles" do
    let(:vms) do
      [
        {
          'name'  => 'master',
          'roles' => ['shell-provisioner', 'potato-provisioner', 'folders-12', 'folders-34', 'shared-networks'],
        },
        {
          'name' => 'agent',
          'roles' => ['shell-provisioner', 'puppet-provisioner', 'folders-34', 'shared-networks'],
        }
      ]
    end

    let(:config) do
      {
        'vms'   => vms,
        'roles' => roles,
      }
    end

    before do
      subject.set_config(dup(config))
      end

    let(:filtered_vms) do
      output = subject.run
      output['vms']
    end

    describe 'the first node' do
      let(:vm) { filtered_vms[0] }
      it 'has the provisioners set in the right order' do
        expected = [
          {'type' => 'potato', 'potato' => 'POHTAHTO.pp'},
          {'type' => 'shell', 'inline' => '/usr/bin/sl'},
        ]
        expect(vm['provisioners']).to eq expected
      end

      it 'has the synced folders set in the right order' do
        expected = [
          {'guest_path' => '/guest-3', 'host_path' => './host-3'},
          {'guest_path' => '/guest-4', 'host_path' => './host-4'},
          {'guest_path' => '/guest-1', 'host_path' => './host-1'},
          {'guest_path' => '/guest-2', 'host_path' => './host-2'},
        ]

        expect(vm['synced_folders']).to eq expected
      end
    end

    describe 'the second node' do
      let(:vm) { filtered_vms[1] }

      it 'has the provisioners set in the right order' do
        expected = [
          {'type' => 'puppet', 'manifest' => 'sl.pp'},
          {'type' => 'puppet', 'manifest' => 'starwars.pp'},
          {'type' => 'shell', 'inline' => '/usr/bin/sl'},
        ]
        expect(vm['provisioners']).to eq expected
      end

      it 'has the synced folders set in the right order' do
        expected = [
          {'guest_path' => '/guest-3', 'host_path' => './host-3'},
          {'guest_path' => '/guest-4', 'host_path' => './host-4'},
        ]

        expect(vm['synced_folders']).to eq expected
      end
    end

    context 'when modifying an array inherited from a role' do
      before :each do
        filtered_vms[0]['private_networks'].push 'ip' => '5.6.7.8'
      end

      it 'other VMs using that role are not affected' do
        expect(filtered_vms[1]['private_networks']).to eq roles['shared-networks']['private_networks']
      end
    end
  end

  describe 'when a class references a non-existent role' do
    let(:config) do
      {
        'vms' => [{'name' => 'master', 'roles' => 'nope'}],
        'roles' => {'yep' => {'box' => 'moxxi'}}
      }
    end

    before do
      subject.set_config(dup(config))
    end

    it 'raises an error' do
      expect { subject.run }.to raise_error(/^Requested role "nope" is not defined/)
    end
  end
end
