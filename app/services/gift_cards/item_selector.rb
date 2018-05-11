module GiftCards
  class ItemSelector
    def self.call(prices, value)
      new(prices: prices, value: value).call
    end

    # This takes in a Hash of prices, and the maximum value that can
    # be realized from our gift card, as determined by the Maximizer
    def initialize(prices:, value:)
      @value = value
      @prices = prices
    end

    def call
      seen  = []
      # Iterate through each of the prices
      prices.values.each do |price|
        # For each price find the compliment, i.e. what would be needed
        # such the price + compliment = value
        compliment = value - price

        # If we have come across the compliment before, we have found a
        # match, and we can return our item pair.
        if seen.include?(compliment)
          pair = [compliment, price]
          items = prices.select { |name, amount| pair.include?(amount) }
          return items
        end

        # If we haven't found a compliment in seen, append the price
        seen << price
      end

      # Return an empty Hash should we not come across any pair
      {}
    end

    private

    attr_reader :prices, :value
  end
end
