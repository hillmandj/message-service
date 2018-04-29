class MessagesController < ApplicationController
  before_action :get_message, only: :show

  def show
    if @message
      render json: { message: @message.text }
    else
      head(:not_found)
    end
  end

  def create
    digest  = Encryption::Digester.call(message_params)
    message = Message.new(text: message_params[:message], digest: digest)

    if message.save
      render json: { digest: digest }
    else
      head(:bad_request)
    end
  end

  private

  def get_message
    @message = Message.find_by(digest: params[:digest])
  end

  def message_params
    params.permit(:message)
  end
end
