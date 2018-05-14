require 'rails_helper'

describe GiftCards::ItemSelector do
  subject(:item_selector) { described_class.new(prices: prices, value: value) }

  let(:prices) do
    {
      'Candy Bar' => 500,
      'Paperback Book' => 700,
      'Detergent' => 1000,
    }
  end

  describe '#call' do
    subject(:call) { item_selector.call }

    context 'when the value is equal to a pair of prices' do
      let(:value) { 1200 }

      it 'returns the best pair' do
        expect(call).to eq(
          { 'Candy Bar' => 500, 'Paperback Book' => 700 }
        )
      end
    end

    # The Maximizer ensures this never happens by always returning a value
    # equal to a pair in the set of prices
    context 'when the value is greater than the largest pair of prices' do
      let(:value) { 2500 }

      it 'returns an empty object' do
        expect(call).to eq({})
      end
    end

    # Same as above
    context 'when the value is less than the largest pair of prices' do
      let(:value) { 1000 }

      it 'returns an empty object' do
        expect(call).to eq({})
      end
    end
  end
end
