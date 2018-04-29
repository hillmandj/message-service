require 'rails_helper'

describe Message do
  subject(:message) { described_class.new(text: text, digest: digest) }

  let(:text) { 'foo' }
  let(:digest) { 'sha256' }

  describe 'validations' do
    describe 'presence' do
      context 'when text and digest are supplied' do
        it { is_expected.to be_valid }
      end

      context 'when there is no text' do
        let(:text) { nil }

        it { is_expected.not_to be_valid }
      end

      context 'when there is no digest' do
        let(:digest) { nil }

        it { is_expected.not_to be_valid }
      end
    end

    describe 'uniqueness' do
      context 'when a message with the same text and digest does not exist' do
        it { is_expected.to be_valid }
      end

      context 'when a message with the same text and digest exists' do
        let!(:existing_message) { create(:message, text: text, digest: digest) }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe 'read only attributes' do
    before { message.save }

    context 'when attempting to modify text' do
      subject(:attempt) { message.update(text: new_text) }

      let(:new_text) { 'bar' }

      it 'does nothing' do
        expect { attempt }.not_to change { message.reload.text }
      end
    end

    context 'when attempting to modify digest' do
      subject(:attempt) { message.update(digest: new_digest) }

      let(:new_digest) { 'sha512' }

      it 'does nothing' do
        expect { attempt }.not_to change { message.reload.digest }
      end
    end

  end
end
