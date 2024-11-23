class Conversation < ApplicationRecord
  # class_name: 'User' để Rails biết rằng cả sender và recipient thực chất đều là bản ghi từ bảng users.
  belongs_to :sender, class_name: "User"
  belongs_to :recipient, class_name: "User"
  has_many :messages, dependent: :destroy

  # Đảm bảo rằng chỉ tồn tại một cuộc hội thoại duy nhất giữa hai người dùng cụ thể.
  validates :sender_id, uniqueness: { scope: :recipient_id }

  # Tìm kiếm tất cả các cuộc hội thoại với sender_id = sender_id và recipient_id = recipient_id.
  # Hoặc với thứ tự ngược lại (sender_id = recipient_id, recipient_id = sender_id).
  scope :between, ->(sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id)
      .or(where(sender_id: recipient_id, recipient_id: sender_id))
  end
end
