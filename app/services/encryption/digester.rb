module Encryption
  # Error class for empty payload.
  class EmptyPayloadError < StandardError; end

  class Digester
    # Shortcut to instantiating and invoking.
    def self.call(payload)
      new(payload).call
    end

    # @param payload [Hash]
    def initialize(payload)
      @payload = payload
    end

    # Return a SHA256 Hexidecimal string based off of the
    # data in the payload. If the payload is empty raise.
    def call
      raise EmptyPayloadError.new if payload.empty?
      Digest::SHA256.hexdigest(message)
    rescue EmptyPayloadError => e
      handle_error(e)
    end

    private

    attr_reader :payload

    # This will just return the payload[:message] for now,
    # but we can eventually generate unique digests based
    # on additional data in the payload.
    #
    # Example:
    #
    # payload: { user_id: 1, message: 'foo'}
    # message: '1-foo'
    def message
      payload.values.join('-')
    end

    # Log the error and return nil
    def handle_error(e)
      Rails.logger.error("Error creating digest: #{e}")
      nil
    end
  end
end
