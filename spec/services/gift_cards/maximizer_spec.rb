require 'rails_helper'

describe GiftCards::Maximizer do
  subject(:maximizer) do
    described_class.new(prices: prices, balance: balance, capacity: capacity)
  end

  # The expectations in this test are primarily based on the values
  # in this data set.
  let(:prices) do
    {
      'Candy Bar' => 500,
      'Paperback Book' => 700,
      'Detergent' => 1000,
    }
  end

  let(:capacity) { 2 }

  describe '#call' do
    subject(:call) { maximizer.call }

    context 'when the balance is greater than all prices' do
      let(:balance) { 2500 }

      it 'returns the maximum amount based on the capacity' do
        expect(call).to eq(1700)
      end

      context 'when the capacity is increased' do
        let(:capacity) { 3 }

        it 'returns the maximum amount based on capacity' do
          expect(call).to eq(2200)
        end
      end
    end

    context 'when the balance can only cover some of the items' do
      let(:balance) { 1400 }

      it 'returns the maximum mount based on the capacity' do
        expect(call).to eq(1200)
      end
    end

    context 'when the balance can\'t cover any items' do
      let(:balance) { 300 }

      it 'returns zero' do
        expect(call).to be_zero
      end
    end
  end
end
