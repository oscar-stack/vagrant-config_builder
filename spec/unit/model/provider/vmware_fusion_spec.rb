require 'spec_helper'
require 'config_builder/model'

describe ConfigBuilder::Model::Provider::VMwareFusion do
  describe "converting to a proc" do

    let(:vmx) { Hash.new }
    let(:fusion_config) { double('fusion provider config', :vmx => vmx) }
    let(:vm_config) { double('vagrant VM config', :provider => fusion_config) }

    before do
      allow(vm_config).to receive(:provider).and_yield(fusion_config)
    end

    it "assigns the gui value to the fusion provider object" do
      subject.attrs = {:gui => 'guivalue'}
      expect(fusion_config).to receive(:gui=).with('guivalue')
      p = subject.to_proc
      p.call(vm_config)
    end

    it "assigns the vmx value to the fusion provider object" do
      subject.attrs = {:vmx => {:hello => 'world'}}
      allow(fusion_config).to receive(:gui=)
      subject.call(vm_config)
      expect(vmx).to eq({:hello => 'world'})
    end
  end
end
