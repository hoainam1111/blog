class Post < ApplicationRecord
  belongs_to :user
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :likes
  has_many :liked_users, through: :likes, source: :user

  def liked_by?(user = nil)
    # Nếu user là nil,
    # phương thức sẽ trả về false ngay lập tức.
    # Điều này giúp đảm bảo rằng nếu không có người dùng nào được cung cấp, phương thức sẽ không thực hiện kiểm tra
    # và trả về false thay vì nil.
    return if user.nil?
    # Sử dụng phương thức include? để kiểm tra xem user có nằm trong danh sách liked_user hay không.
    liked_users.include?(user)
  end
end
