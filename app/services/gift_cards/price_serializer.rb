module GiftCards
  class PriceSerializer
    def self.call(file_path, balance)
      new(file_path: file_path, balance: balance).call
    end

    def initialize(file_path:, balance:)
      @file_path = file_path
      @balance = balance
    end

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
