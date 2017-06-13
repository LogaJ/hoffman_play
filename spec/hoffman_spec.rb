require_relative '../lib/hoffman'

RSpec.describe Hoffman do
  let(:dictionary) {{'m' => 1, 'p' => 2, 'i' => 4, 's' => 4}}

  describe '.frequency' do
    let(:word) {'Mississippi'}
    it 'returns a dictionary of word frequency usage' do
      expect(described_class.frequency(word)).to eq(dictionary)
    end
  end

  describe '.build_leaves' do
    let(:expected_array_of_leaves) do
      [
        have_attributes(char: 's', weight: 4),
        have_attributes(char: 'i', weight: 4),
        have_attributes(char: 'p', weight: 2),
        have_attributes(char: 'm', weight: 1)
      ]
    end

    it 'returns an array of leaf objects' do
      expect(described_class.build_leaves(dictionary)).to match(expected_array_of_leaves)
    end
  end

  describe '.build_tree' do
    it 'returns a tree representing the top leaf' do
      expect(
        described_class.build_tree(described_class.build_leaves(dictionary))
      ).to match(be_a_kind_of(Tree))

      expect(described_class.build_tree(described_class.build_leaves(dictionary)).frequency).to eq(11)
    end

  end
end