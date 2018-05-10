module GiftCards
  class Maximizer
    def self.call(prices, balance, capacity)
      new(prices, balance, capacity).call
    end

    def initialize(prices, balance, capacity)
      @prices = prices
      @balance = balance
      @capacity = capacity
    end

    def call
      max(balance, capacity)
    end

    private

    attr_reader :prices, :balance, :capacity

    def max(remaining_balance, remaining_capacity, pointer = prices.length - 1)
      return 0 if remaining_balance.zero? || remaining_capacity.zero? || pointer < 0

      current_price = prices.values[pointer]

      if current_price > remaining_balance
        result = max(remaining_balance, remaining_capacity, pointer - 1)
      else
        temp1 = max(remaining_balance, remaining_capacity, pointer - 1)

        temp2 = current_price + max(
          remaining_balance - current_price, remaining_capacity - 1, pointer - 1
        )

        result = [temp1, temp2].max
      end

      result
    end
  end
end
