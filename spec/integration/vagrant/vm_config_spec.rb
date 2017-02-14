require 'spec_helper'

describe 'Vagrant Integration: ConfigBuilder::Model::VM' do
  include_context 'vagrant-unit'

  # Set inside test contexts to generate Vagrant configuration.
  let(:config_data) { Hash.new }

  let(:test_env)    { isolated_environment }
  let(:env)         {
    test_env.create_vagrant_env(local_data_path: "#{test_env.workdir}/.vagrant")
  }
  let(:root_config) { env.vagrantfile.config }

  before(:each) do
    model = ConfigBuilder::Model::Root.new_from_hash(config_data)

    model.call(root_config)
  end

  context 'when building vms' do
    let(:config_data) {
      {'vms' =>
        [
          {'name' => 'machine1', 'primary' => true},
          {'name' => 'machine2', 'autostart' => false},
        ]
      }
    }

    subject { root_config.vm }

    it 'defines named machines under Vagrant config.vm' do
      expect(subject.defined_vm_keys).to include(:machine1, :machine2)
    end

    it 'sets the autostart option when defining machines' do
      test_vm = subject.defined_vms[:machine2]

      expect(test_vm.options[:autostart]).to be_false
    end

    it 'sets the primary option when defining machines' do
      test_vm = subject.defined_vms[:machine1]

      expect(test_vm.options[:primary]).to be_true
    end
  end

  context 'when configuring vms' do
    let(:config_data) {
      {'vms' =>
        [
          {
            'name'             => 'test',
            'hostname'         => 'test-vm',
            'box'              => 'testbox',
            'communicator'     => 'winrm',
            'forwarded_ports'  => [
              {'id' => 'winrm', 'host' => 666}
            ],
            'synced_folders'   => [
              {'host_path' => '.', 'guest_path' => '/vagrant', 'disabled' => true}
            ],
            'private_networks' => [
              {'type' => 'dhcp'}
            ],
            'public_networks' => [
              {'bridge' => 'some_interface:'}
            ],
          },
        ]
      }
    }

    subject { env.machine(:test, :dummy).config.vm }

    it 'sets Vagrant VM attributes' do
      expect(subject.box).to eq 'testbox'
      expect(subject.communicator).to eq :winrm
      expect(subject.hostname).to eq 'test-vm'
    end

    it 'configures Vagrant forwarded ports' do
      winrm_port = subject.networks.find {|t, o| t == :forwarded_port && o[:id] == 'winrm'}

      expect(winrm_port.last[:host]).to eq 666
    end

    it 'configures Vagrant synced folders' do
      expect(subject.synced_folders['/vagrant'][:disabled]).to be_true
    end

    it 'configures Vagrant private networks' do
      private_networks = subject.networks.select {|t, o| t == :private_network}

      expect(private_networks).to_not be_empty
    end

    it 'configures Vagrant public networks' do
      private_networks = subject.networks.select {|t, o| t == :public_network}

      expect(private_networks).to_not be_empty
    end
  end

end
