module Encryption
  class Encoder
    # Convenience method
    def self.call(payload)
      new(payload).call
    end

    def initialize(payload)
      @payload = payload
    end

    def call
      Digest::SHA256.hexdigest(key)
    end

    private

    attr_reader :payload

    # Simple for now, but we can eventually generate
    # unique keys based on specific ordering of the data
    # in the payload
    #
    # Example:
    #
    # payload: { user_id: 1, message: 'foo'}
    # key: '1-foo'
    def key
      payload.values.join('-')
    end
  end
end
