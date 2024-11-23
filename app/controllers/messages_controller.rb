class MessagesController < ApplicationController
  before_action :authenticate_user!
  def index
    @messages = @conversation.messages.order(:created_at)
    @message = @conversation.messages.new
  end
  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user
    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to conversation_messages_path(@conversation) }
      end
    else
      render :index, status: :unprocessable_entity
    end
  end
  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
