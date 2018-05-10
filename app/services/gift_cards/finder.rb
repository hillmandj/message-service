module GiftCards
  class Finder
    DEFAULT_PRICES = {
      'Candy Bar' => 500,
      'Paperback Book' => 700,
      'Detergent' => 1000,
      'Headphones' => 1400,
      'Earmuffs' => 2000,
      'Bluetooth Stereo' => 6000,
    }

    MAXIMUM_CAPACITY = 2

    def initialize(prices: DEFAULT_PRICES, balance:)
      @prices = prices
      @balance = balance
    end

    def call
      Pairer.call(prices, max_card_value)
    end

    private

    attr_reader :prices, :balance

    def max_card_value
      Maximizer.call(prices, balance, capacity)
    end

    def capacity
      MAXIMUM_CAPACITY
    end
  end
end
