class MessagesController < ApplicationController
  layout "chat"
  before_action :authenticate_user!
  before_action :set_conversation
  def create
    # Tạo tin nhắn mới trong đoạn hội thoại hiện tại
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      # Sử dụng Turbo hoặc AJAX để cập nhật giao diện
      redirect_to conversations_path(conversation_id: @conversation.id)
    else
      # Xử lý lỗi nếu không lưu được tin nhắn
      flash[:alert] = "Unable to send message."
      redirect_to conversations_path(conversation_id: @conversation.id)
    end
  end

  private

  def set_conversation
    @conversation = Conversation.find_by(id: params[:conversation_id])
  end

  def message_params
    params.require(:message).permit(:content)
  end
end
