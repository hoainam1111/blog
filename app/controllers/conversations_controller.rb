class ConversationsController < ApplicationController
  layout "chat"
  before_action :authenticate_user!
  def index
   # Danh sách tất cả các đoạn hội thoại của người dùng
   @conversations = Conversation.where(sender: current_user).or(Conversation.where(recipient: current_user))

   if params[:conversation_id]
    @conversation = @conversations.find_by(id: params[:conversation_id])
    @messages = @conversation&.messages&.order(:created_at) || []
    @message = @conversation.messages.new if @conversation
   end
  end
  def create
    @conversation = Conversation.between(current_user.id, params[:recipient_id]).first_or_initialize do |conversation|
      conversation.sender_id = current_user.id
      conversation.recipient_id = params[:recipient_id]
    end
    if @conversation.save
      redirect_to conversations_path(conversation_id: @conversation.id)
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
