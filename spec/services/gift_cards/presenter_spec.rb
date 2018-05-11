require 'rails_helper'

describe GiftCards::Presenter do
  subject(:presenter) { described_class.new(items: items) }


  describe '#call' do
    subject(:call) { presenter.call }

    context 'when items exist' do
      let(:items) do
        {
          'Candy Bar' => 500,
          'Paperback Book' => 700,
        }
      end

      let(:formatted_string) { 'Candy Bar 500, Paperback Book 700' }

      it 'returns formatted string' do
        expect(call).to eq(formatted_string)
      end
    end

    context 'when there are no items' do
      let(:items) { {} }

      let(:error_message) { GiftCards::Presenter::ERROR_MESSAGE }

      it 'returns the error message string' do
        expect(call).to eq(error_message)
      end
    end
  end
end
