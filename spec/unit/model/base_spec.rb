require 'spec_helper'

describe ConfigBuilder::Model::Base do
  context 'when initialized with attributes' do
    subject do
      described_class.new_from_hash({'attr_1' => 'val_1', 'attr_2' => 'val_2'})
    end

    it 'provides access via #attr' do
      expect(subject.attr(:attr_1)).to eq 'val_1'
    end

    it 'provides conditional access via #with_attr' do
      test_val_2 = nil
      test_val_3 = nil

      subject.with_attr(:attr_2) { |value| test_val_2 = value }
      subject.with_attr(:non_existent) { |value| test_val_3 = value }

      expect(test_val_2).to eq 'val_2'
      expect(test_val_3).to be_nil
    end
  end

  context 'when subclassed' do
    let (:subclass_a) do
      Class.new(described_class) do
        def_model_id :id_key

        def_model_attribute :attr_1
        def_model_attribute :attr_2

        def_model_option :opt_1
        def_model_option :opt_2

        def configure_attr_2(config, value)
          config.custom_setter(value)
        end
      end
    end

    subject { subclass_a }

    it 'responds to .model_id' do
      expect(subject.model_id).to eq :id_key
    end

    it 'lists attributes via .model_attributes' do
      expect(subject.model_attributes).to include(:attr_1, :attr_2)
    end

    it 'lists options via .model_options' do
      expect(subject.model_options).to include(:opt_1, :opt_2)
    end

    it 'returns #instance_id by using .model_id' do
      instance = subject.new_from_hash({'id_key' => 'id_value'})

      expect(instance.instance_id).to eq 'id_value'
    end

    it 'returns all set options via #instance_options' do
      instance = subject.new_from_hash({'opt_1' => 'option_value'})

      expect(instance.instance_options).to eq({:opt_1 => 'option_value'})
    end

    it 'copies attributes to config objects with #configure!' do
      config = double('vagrant config')
      instance = subject.new_from_hash({'attr_1' => 'attr_value'})

      expect(config).to receive("attr_1=").with('attr_value')

      instance.configure!(config)
    end

    it 'uses custom setters to copy attributes with #configure!' do
      config = double('vagrant config')
      instance = subject.new_from_hash({'attr_2' => 'custom_value'})

      expect(config).to receive("custom_setter").with('custom_value')

      instance.configure!(config)
    end

    context 'when subclassed further' do
      let (:subclass_b) do
        Class.new(subclass_a) do
          def_model_attribute :attr_3

          def_model_option :opt_3
        end
      end

      subject { subclass_b }

      it 'lists inherited attributes via .model_attributes' do
        expect(subject.model_attributes).to include(:attr_1, :attr_2, :attr_3)
      end

      it 'lists inherited options via .model_options' do
        expect(subject.model_options).to include(:opt_1, :opt_2, :opt_3)
      end

      it 'does not inherit model_id' do
        expect(subject.model_id).to be_nil
      end
    end
  end
end
