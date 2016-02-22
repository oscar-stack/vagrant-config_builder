require 'spec_helper'

describe ConfigBuilder::Filter::Boxes do

  def dup(o)
    Marshal.load(Marshal.dump(o))
  end

  let(:boxes) do
    {
      'first_box'  => 'http://box_host/first_box.box',
      'second_box' => 'http://box_host/second_box.box',
      'third_box'  => 'http://box_host/third_box.box',
    }
  end

  let(:vms) do
    [
      {'name' => 'one',  'box'  => 'first_box'},
      {'name' => 'two',  'box'  => 'second_box'},
      {'name' => 'four', 'box'  => 'fourth_box'},
      {
        'name'    => 'five',
        'box'     => 'fifth_box',
        'box_url' => 'https://another_box_host/fifth_box.box',
      },
    ]
  end

  describe 'without a boxes key' do
    let(:config) do
      {
        'vms' => vms,
      }
    end

    before { subject.set_config(config) }

    it "doesn't modify any boxes" do
      input = dup(config)
      output = subject.run
      expect(output).to eq config
    end
  end

  describe 'when the boxes key is given' do
    let(:config) do
      {
        'boxes' => boxes,
        'vms'   => vms,
      }
    end

    before { subject.set_config(config) }

    it "removes the 'boxes' key" do
      output = subject.run
      expect(output).to_not have_key 'boxes'
    end

    it "adds the 'box_url' to VMs whose 'box' value is in the 'boxes' list" do
      output = subject.run
      vms    = output['vms']

      expect(vms[0]['box_url']).to eq 'http://box_host/first_box.box'
      expect(vms[1]['box_url']).to eq 'http://box_host/second_box.box'
    end

    describe "if the VM 'box' value doesn't have a match in the box list" do
      it "doesn't modify the 'box_url'" do
        output = subject.run
        vms    = output['vms']

        expect(vms[2]['box_url']).to be_nil
      end
    end

    describe "if the VM 'box_url' is already set" do
      it "doesn't modify the 'box_url'" do
        output = subject.run
        vms    = output['vms']

        expect(vms[3]['box_url']).to eq 'https://another_box_host/fifth_box.box'
      end
    end
  end
end
