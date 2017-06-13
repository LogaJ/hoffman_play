class Hoffman
  class << self
    def frequency(word)
      word.downcase.split('').each_with_object(Hash.new(0)) do |char, hash|
        hash[char] += 1
      end
    end

    def build_leaves(dictionary)
      dictionary.map do |char, frequency|
        Leaf.new(char, frequency)
      end.sort_by {|leaf| leaf.frequency}.reverse
    end

    def build_tree(leaves)
      until leaves.length == 1 do
        node_1, node_2 = leaves.pop(2)
        leaves <<  Tree.new(
            left_side: node_1,
            right_side: node_2,
            chars: [], #TODO return all chars from leaves
            frequency: node_1.frequency + node_2.frequency
          )
      end

      leaves.first
    end
  end
end

class Tree
  def initialize(left_side:, right_side:, chars:, frequency:)
    @left_side = left_side
    @right_side = right_side
    @chars = chars
    @frequency = frequency
  end

  attr_reader :left_side, :right_side, :chars, :frequency
end

class Leaf
  def initialize(char, frequency)
    @char = char
    @frequency = frequency
  end

  attr_reader :char, :frequency
end

