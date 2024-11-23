class ConversationsController < ApplicationController
  layout "chat"
  before_action :authenticate_user!
  def index
    # Lấy tất cả các cuộc hội thoại liên quan đến người dùng hiện tại (current_user), bất kể họ là người gửi hay người nhận.
    @conversations = Conversation.where(sender: current_user).or(Conversation.where(recipient: current_user))
  end
  def create
    @conversation = Conversation.between(current_user.id, params[:recipient_id]).first_or_initialize
    if @conversation.save
      redirect_to conversation_messages_path(@conversation)
    else
      flash[:alert] = @conversation.errors.full_messages.join(", ")
      redirect_back(fallback_location: root_path)
    end
  end
  private
  def conversation_params
    params.require(:conversation).permit(:recipient_id)
  end
end
