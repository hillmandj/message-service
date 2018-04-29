require 'rails_helper'

describe Encryption::Digester do
  subject(:digester) { described_class.new(payload) }

  let(:payload) { { message: message } }
  let(:message) { 'foo' }

  # Test for shortcut class method.
  describe '.call' do
    subject(:call) { described_class.call(payload) }

    let(:instance) { instance_double(Encryption::Digester, call: nil) }

    # This tests instantiation without using the mocked instance above
    it 'creates an instance of the digester' do
      expect(described_class).to receive(:new)
        .with(payload).and_call_original

      call
    end

    it 'invokes the call method on the instance' do
      allow(described_class).to receive(:new).and_return(instance)
      expect(instance).to receive(:call)
      call
    end
  end

  # Test for instance method that creates the digest.
  describe '#call' do
    subject(:call) { digester.call }

    context 'when a valid payload is passed' do
      it 'calls the built in ruby digest library' do
        expect(Digest::SHA256).to receive(:hexdigest).with(message)
        call
      end

      it 'invokes the message method' do
        expect(digester).to receive(:message).and_call_original
        call
      end

      it 'returns a string' do
        expect(call).to be_a(String)
      end
    end

    context 'when an invalid payload is passed' do
      context 'when the payload is blank' do
        let(:payload) { {} }

        it 'handles the error' do
          expect(digester).to receive(:handle_error)
            .with(instance_of(Encryption::EmptyPayloadError))

          call
        end

        it 'logs the error' do
          expect(Rails.logger).to receive(:error).with(instance_of(String))
          call
        end

        it 'returns nil' do
          expect(call).to be_nil
        end
      end
    end
  end
end
