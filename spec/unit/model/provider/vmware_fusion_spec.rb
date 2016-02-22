require 'spec_helper'
require 'config_builder/model'

describe ConfigBuilder::Model::Provider::VMwareFusion do
  describe "converting to a proc" do

    let(:vmx) { Hash.new }
    let(:vm_config) { double('vagrant VM config', :provider => provider_config) }
    let(:provider_config) { double('fusion provider config', :vmx => vmx) }
    let(:override_config) { double('fusion override config') }

    before do
      allow(vm_config).to receive(:provider).and_yield(provider_config, override_config)
    end

    it "assigns the gui value to the fusion provider object" do
      subject.attrs = {:gui => 'guivalue'}
      expect(provider_config).to receive(:gui=).with('guivalue')
      p = subject.to_proc
      p.call(vm_config)
    end

    it "assigns the vmx value to the fusion provider object" do
      subject.attrs = {:vmx => {:hello => 'world'}}
      allow(provider_config).to receive(:gui=)
      subject.call(vm_config)
      expect(vmx).to eq({:hello => 'world'})
    end
  end
end
