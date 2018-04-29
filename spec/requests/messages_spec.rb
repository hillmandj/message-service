require 'rails_helper'

describe "Message Requests", type: :request do
  describe 'create' do
    subject(:action) do
      post '/messages', params: params
      response
    end

    let(:params) { { message: 'foo' } }

    context 'when the message is valid' do
      it 'responds with success' do
        expect(action).to be_ok
        expect(action.status).to eq(200)
      end

      it 'creates a new message' do
        expect { action }.to change { Message.count }.by(1)
      end
    end

    context 'when the message is invalid' do
      context 'when a message with the same data already exists' do
        # Creating a message in the database before making the request.
        # This will generate the same digest and violate our uniqueness constraint.
        let!(:existing_message) { create(:message, text: params[:message]) }

        it 'responds with failure' do
          expect(action).not_to be_ok
          expect(action.status).to eq(400)
        end
      end
    end

    context 'when the payload is blank' do
      let(:params) { {} }

      it 'responds with failure' do
        expect(action).not_to be_ok
        expect(action.status).to eq(400)
      end
    end
  end

  describe 'show' do
    subject(:action) do
      get "/messages/#{digest}"
      response
    end

    let(:message) { create(:message) }
    let(:digest) { message.digest }

    context 'when the message exists' do
      it 'responds with success' do
        expect(action).to be_ok
        expect(action.status).to eq(200)
      end

      describe 'message response' do
        subject(:message_response) { JSON.parse(action.body) }

        it 'includes the message text' do
          expect(message_response).to include('message' => message.text)
        end
      end
    end

    context 'when the message does not exist' do
      let(:digest) { 'idontexist' }

      it 'response with failure' do
        expect(action).not_to be_ok
        expect(action.status).to eq(404)
      end
    end
  end
end
