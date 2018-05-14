module GiftCards
  class PriceSerializer
    def self.call(file_path, balance)
      new(file_path: file_path, balance: balance).call
    end

    def initialize(file_path:, balance:)
      @file_path = file_path
      @balance = balance
    end

    # Read in all prices from a file, this expects each line in the file to be
    # in the format: Name of Item, Price of Item
    #
    # We convert Price of Item to an integer.
    #
    # This also expects that the items are already by price in ascending order.
    # This allows us to stop reading in lines once we have exceeded our gift card
    # balance, since we will not need to evaluate those prices.
    def call
      {}.tap do |prices|
        File.foreach(file_path).each do |line|
          name, price = line.split(', ').map(&:strip)
          price = price.to_i
          break if price > balance
          prices[name] = price
        end
      end
    end

    private

    attr_reader :file_path, :balance
  end
end
