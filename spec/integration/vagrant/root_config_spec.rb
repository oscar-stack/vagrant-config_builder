require 'spec_helper'

describe 'Vagrant Integration: ConfigBuilder::Model::Root' do
  include_context 'vagrant-unit'

  # Set inside test contexts to generate Vagrant configuration.
  let(:config_data) { Hash.new }

  let(:test_env)    { isolated_environment }
  let(:env)         { test_env.create_vagrant_env }
  let(:root_config) { env.vagrantfile.config }

  before(:each) do
    model = ConfigBuilder::Model::Root.new_from_hash(config_data)

    model.call(root_config)
  end

  context 'when configured with ssh data' do
    let(:config_data) {
      {'ssh' =>
        {
          'insert_key' => false,
          'username'   => 'AzureDiamond',
          'password'   => 'hunter2',
        }
      }
    }

    subject { root_config.ssh }

    it 'sets Vagrant config.ssh parameters' do
      expect(subject.insert_key).to be_falsey
      expect(subject.username).to eq 'AzureDiamond'
      expect(subject.password).to eq 'hunter2'
    end
  end

  context 'when configured with WinRM data' do
    let(:config_data) {
      {'winrm' =>
        {
          'username'   => 'AzureDiamond',
          'password'   => 'hunter2',
        }
      }
    }

    subject { root_config.winrm }

    it 'sets Vagrant config.winrm parameters' do
      expect(subject.username).to eq 'AzureDiamond'
      expect(subject.password).to eq 'hunter2'
    end
  end

  context 'when configured with NFS data' do
    let(:config_data) {
      {'nfs' =>
        {
          'map_uid'  => 42,
        }
      }
    }

    subject { root_config.nfs }

    it 'sets Vagrant config.nfs parameters' do
      expect(subject.map_uid).to eq 42
    end
  end

  context 'when configured with VM defaults' do
    let(:config_data) {
      {'vm_defaults' =>
        {
          'box'  => 'somebox',
        }
      }
    }

    subject { root_config.vm }

    it 'sets Vagrant config.vm parameters' do
      expect(subject.box).to eq 'somebox'
    end
  end

end
