class Api::V1::MessagesController < ApplicationController
  before_action :find_channel, only: %i[index create]

  def index
    @messages = @channel.messages.order('created_at ASC')
    render json: @messages
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    @message.channel = find_channel
    @message.save
    render json: @message
  end

  private

  def find_channel
    @channel = Channel.find_by_name(params[:channel_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
