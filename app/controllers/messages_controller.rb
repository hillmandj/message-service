class MessagesController < ApplicationController
  before_action :get_decoded_token, only: :show

  def show
    if @token
      render json: { message: token }
    else
      head(:not_found)
    end
  end

  def create
    token = Encryption::Encoder.call(message_params)

    if token
      render json: { digest: token }
    else
      head(:bad_request)
    end
  end

  private

  def get_decoded_token
    @token = Encryption::Validator.call(params[:token])
  end

  def message_params
    params.permit(:message)
  end
end
