class Like < ApplicationRecord
  belongs_to :post
  belongs_to :user
  # Đảm bảo một người dùng chỉ có thể like một bài viết một lần
  validates :user_id, uniqueness: { scope: :post_id }
end