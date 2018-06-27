require 'spec_helper'

describe 'Vagrant Integration: ConfigBuilder::Model::Provisioner' do
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

  context 'when building provisioners' do
    let(:config_data) {
      {'vms' =>
        [
          {
            'name'             => 'test',
            'provisioners'     => [
              {'type' => 'shell', 'run' => 'once'},
              {'type' => 'file', 'name' => 'supercoolfile'},
            ],
          },
        ]
      }
    }

    subject { env.machine(:test, :dummy).config.vm }

    it 'defines provisioners' do
      expect(subject.provisioners.length).to eq(2)
    end

    it 'sets provisioner names' do
      if Vagrant::VERSION < '1.7'
        provisioner = subject.provisioners.find {|p| p.name == :file}

        expect(provisioner.id).to eq 'supercoolfile'
      else
        provisioner = subject.provisioners.find {|p| p.type == :file}

        expect(provisioner.name).to eq :supercoolfile
      end
    end

    it 'sets provisioner options' do
      if Vagrant::VERSION < '1.7'
        provisioner = subject.provisioners.find {|p| p.name == :shell}

        expect(provisioner.run).to eq :once
      else
        provisioner = subject.provisioners.find {|p| p.type == :shell}

        expect(provisioner.run).to eq :once
      end
    end
  end

  context 'when configuring provisioners' do
    let(:config_data) {
      {'vms' =>
        [
          {
            'name'             => 'test',
            'provisioners'     => [
              {'type' => 'shell', 'inline' => 'hello world'},
            ],
          },
        ]
      }
    }

    subject { env.machine(:test, :dummy).config.vm }

    it 'sets provisioner attributes' do
      shell_config = subject.provisioners.first.config

      expect(shell_config.inline).to eq 'hello world'
    end
  end

end
