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
      }
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

  describe 'removing the role' do
    let(:config) do
      {
        'vms' => [{'name' => 'master'}],
        'roles' => roles,
      }
    end

    before do
      subject.set_config(dup(config))
    end

    it 'strips out the roles key' do
      output = subject.run
      expect(output).to_not have_key 'roles'
    end
  end

  describe 'and a vm with no roles' do
    let(:vms) { [{'name' => 'master'}] }

    let(:config) do
      {
        'vms'   => vms,
        'roles' => roles,
      }
    end

    before do
      subject.set_config(dup(config))
    end

    it "doesn't alter the vm" do
      output = subject.run
      expect(output['vms']).to eq vms
    end
  end

  describe 'and one vm' do
    describe 'with one role' do
      let(:vms) { [{'name' => 'master', 'roles' => 'shell-provisioner'}] }

      let(:config) do
        {
          'vms'   => vms,
          'roles' => roles,
        }
      end

      before do
        subject.set_config(dup(config))
      end

      let(:filtered_vm) do
        output = subject.run
        output['vms'][0]
      end

      it "removes the 'roles' key" do
        expect(filtered_vm).to_not have_key 'roles'
      end

      it 'applies the role' do
        expected = [{
          'type'   => 'shell',
          'inline' => '/usr/bin/sl',
        }]

        expect(filtered_vm['provisioners']).to eq expected
      end
    end

    describe 'with two roles' do
      let(:vms) do
        [{
          'name'  => 'master',
          'roles' => ['shell-provisioner', 'folders-12'],
        }]
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

      let(:filtered_vm) do
        output = subject.run
        output['vms'][0]
      end

      it 'applies all of the roles' do
        expected_prov = [{
          'type'   => 'shell',
          'inline' => '/usr/bin/sl',
        }]

        expected_folder = [
          {'guest_path' => '/guest-1', 'host_path' => './host-1'},
          {'guest_path' => '/guest-2', 'host_path' => './host-2'},
        ]

        expect(filtered_vm['provisioners']).to eq expected_prov
        expect(filtered_vm['synced_folders']).to eq expected_folder
      end
    end
  end

  describe "with multiple VMs and shared roles" do
    let(:vms) do
      [
        {
          'name'  => 'master',
          'roles' => ['shell-provisioner', 'potato-provisioner', 'folders-12', 'folders-34'],
        },
        {
          'name' => 'agent',
          'roles' => ['shell-provisioner', 'puppet-provisioner', 'folders-34'],
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
  end

  describe 'when a class references a non-existent role' do
    let(:config) do
      {
        'vms' => [{'name' => 'master', 'roles' => 'nope'}],
        'roles' => {'yep' => {'box' => 'moxxi'}}
      }

      before do
        subject.set_config(dup(config))
      end

      it 'raises an error' do
        expect { subject.run }.to raise_error, /Couldn't find role named .*nope.*/
      end
    end
  end
end
