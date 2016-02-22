require 'spec_helper'

class DummyModel < ConfigBuilder::Model::Provider::Base
  def instance_id
    'dummy'
  end

  ConfigBuilder::Model::Provider.register('dummy', self)
end

describe 'Vagrant Integration: ConfigBuilder::Model::Provider' do
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

  context 'when configuring providers' do
    let(:config_data) {
      {'vms' =>
        [
          {
            'name'             => 'test',
            'providers'        => [
              {
                'type' => 'dummy',
                'overrides' => {
                  'ssh' => {'username' => 'AzureDiamond'},
                  'vm_defaults' => {'box' => 'testbox'},
                },
              },
            ],
          },
        ]
      }
    }

    subject { env.machine(:test, :dummy) }

    it 'sets configuration overrides' do #YAAARP.
      expect(subject.config.ssh.username).to eq 'AzureDiamond'
      expect(subject.config.vm.box).to eq 'testbox'
    end
  end

end
