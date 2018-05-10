module GiftCards
  class Pairer
    def self.call(prices, value)
      new(prices: prices, value: value).call
    end

    def initialize(prices:, value:)
      @value = value
      @prices = prices
    end

    def call
      seen  = []

      prices.values.each do |price|
        compliment = value - price

        if seen.include?(compliment)
          pair = [compliment, price]
          items = prices.select { |name, amount| pair.include?(amount) }
          return items
        end

        seen << price
      end

      {}
    end

    private

    attr_reader :prices, :value
  end
end
