require 'spec_helper'

describe ConfigBuilder::Loader::YAML do
  describe '#yamldir' do

    before :each do
      # Simulate directories of YAML files for the loader.
      allow(File).to receive(:join).with('tst_dir_a', anything()).and_return('tst_dir_a')
      allow(File).to receive(:join).with('tst_dir_b', anything()).and_return('tst_dir_b')

      allow(Dir).to receive(:glob).with('tst_dir_a').and_return(['a/boxes.yaml', 'a/roles.yaml'])
      allow(Dir).to receive(:glob).with('tst_dir_b').and_return(['b/boxes.yaml', 'b/roles.yaml'])

      allow(::YAML).to receive(:load_file).with('a/boxes.yaml').and_return(::YAML.load <<-EOF)
---
boxes:
  'box-a': 'http://puppet-vagrant-boxes.puppetlabs.com/'
      EOF

      allow(::YAML).to receive(:load_file).with('a/roles.yaml').and_return(::YAML.load <<-EOF)
---
roles:
  base:
    private_networks:
      - {ip: '0.0.0.0', auto_network: true}
      EOF

      allow(::YAML).to receive(:load_file).with('b/boxes.yaml').and_return(::YAML.load <<-EOF)
---
boxes:
  'box-b': 'http://puppet-vagrant-boxes.puppetlabs.com/'
      EOF

      allow(::YAML).to receive(:load_file).with('b/roles.yaml').and_return(::YAML.load <<-EOF)
---
roles:
  base:
    private_networks:
      - {ip: '10.0.0.1'}
      EOF
    end


    it 'loads from single directories' do
      subject.yamldir('tst_dir_a')

      expect(::YAML).to have_received(:load_file).exactly(2).times
    end

    it 'loads from multiple directories' do
      subject.yamldir(['tst_dir_a', 'tst_dir_b'])

      expect(::YAML).to have_received(:load_file).exactly(4).times
    end

    it 'merges separate hashes' do
      config = subject.yamldir('tst_dir_a')

      expect(config).to have_key('boxes')
      expect(config).to have_key('roles')
    end

    describe 'when merging overlapping configs' do
      let(:config) { subject.yamldir(['tst_dir_a', 'tst_dir_b']) }

      it 'merges subhashes' do
        expect(config['boxes']).to have_key('box-a')
        expect(config['boxes']).to have_key('box-b')
      end

      it 'concatenates subarrays' do
        expect(config['roles']['base']['private_networks']).to have(2).items
      end
    end
  end
end
