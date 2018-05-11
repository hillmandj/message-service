module GiftCards
  class Formatter
    def self.call(items)
      new(items: items).call
    end

    def initialize(items:)
      @items = items
    end

    def call
      if items.empty?
        error_message
      else
        formatted_items
      end
    end

    private

    attr_reader :items

    def error_message
      'Not possible'
    end

    def formatted_items
      [].tap do |output|
        items.each do |name, amount|
          output << "#{name} #{amount}"
        end
      end.join(', ')
    end
  end
end
