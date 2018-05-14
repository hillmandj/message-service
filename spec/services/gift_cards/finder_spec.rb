require 'rails_helper'

describe GiftCards::Finder do
  subject(:finder) do
    described_class.new(prices: prices, balance: balance)
  end

  let(:prices) do
    {
      'Candy Bar' => 500,
      'Paperback Book' => 700,
    }
  end

  let(:balance) { 2500 }

  describe '#call' do
    subject(:call) { finder.call }

    let(:capacity) { GiftCards::Finder::MAXIMUM_CAPACITY }

    it 'invokes the item selector' do
      expect(GiftCards::ItemSelector).to receive(:call).with(prices, kind_of(Integer))
      call
    end

    it 'fetches the max card value' do
      allow(GiftCards::ItemSelector).to receive(:call)
      expect(GiftCards::Maximizer).to receive(:call).with(prices, balance, capacity)
      call
    end
  end
end
