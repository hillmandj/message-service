module GiftCards
  class Finder
    MAXIMUM_CAPACITY = 2

    def self.call(prices, balance)
      new(prices: prices, balance: balance).call
    end

    def initialize(prices:, balance:)
      @prices = prices
      @balance = balance
    end

    # This calls our Pairer after obtaining the maximum card value
    # from our Maximizer class below. It returns a Hash of the best
    # items we can choose for two people. If no such pair exists, it
    # returns an empty Hash.
    #
    # If we were able to handle more than 2 values, this class would
    # not be called 'Pairer'
    def call
      Pairer.call(prices, max_card_value)
    end

    private

    attr_reader :prices, :balance

    # This calls the Maximizer class which finds the best possible value
    # we can get from our gift card. It can handle any capacity, but we
    # are only solving for a capacity of 2, since our Pairer class can only
    # return 2 items.
    def max_card_value
      Maximizer.call(prices, balance, capacity)
    end

    # Ideally, this would be something we would pass to our initializer
    # should we improve this class to handle more than 2 gifts.
    def capacity
      MAXIMUM_CAPACITY
    end
  end
end
