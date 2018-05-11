module GiftCards
  class Maximizer
    def self.call(prices, balance, capacity)
      new(prices: prices, balance: balance, capacity: capacity).call
    end

    def initialize(prices:, balance:, capacity:)
      @memo = {}
      @prices = prices
      @balance = balance
      @capacity = capacity
    end

    def call
      max(balance, capacity)
    end

    private

    attr_reader :memo, :prices, :balance, :capacity
    attr_writer :memo

    def max(remaining_balance, remaining_capacity, pointer = prices.length - 1)
      # If we already have come across this combination, return memoized result
      # This helps us if different items share the same price in our price list
      if memo.key?([remaining_balance, remaining_capacity, pointer])
        return memo.fetch([remaining_balance, remaining_capacity, pointer])
      end

      # This is our recursive termination condition
      if remaining_balance <= 0 || remaining_capacity.zero? || pointer < 0
        return 0
      end

      # This is our current price, because the list is sorted, we can select by index
      current_price = prices.values[pointer]

      # If the current price is greater than the remaining balance, move on by reducing
      # the pointer, and not altering the remaining_balance or remaining_capacity
      if current_price > remaining_balance
        result = max(remaining_balance, remaining_capacity, pointer - 1)
      else
        # Check what it would be like to not select the item
        unselected = max(remaining_balance, remaining_capacity, pointer - 1)

        # Check what it would be like to actually select the item
        selected = current_price + max(
          remaining_balance - current_price, remaining_capacity - 1, pointer - 1
        )

        # Pick between the two values
        result = [unselected, selected].max
      end

      # Store the result in our memo, using all parameters as the key
      memo.store([remaining_balance, remaining_capacity, pointer], result)

      result
    end
  end
end
