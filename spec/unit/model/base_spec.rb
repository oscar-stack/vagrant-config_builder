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
        def_model_attribute :attr_1
        def_model_attribute :attr_2
      end
    end

    subject { subclass_a }

    it 'lists attributes via .model_attributes' do
      expect(subject.model_attributes).to include(:attr_1, :attr_2)
    end

    context 'when subclassed further' do
      let (:subclass_b) do
        Class.new(subclass_a) do
          def_model_attribute :attr_3
        end
      end

      subject { subclass_b }

      it 'lists inherited attributes via .model_attributes' do
        expect(subject.model_attributes).to include(:attr_1, :attr_2, :attr_3)
      end
    end
  end
end
