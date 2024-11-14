class Post < ApplicationRecord
  belongs_to :user

  belongs_to :category
  has_many :likes
  has_many :liked_users, through: :likes, source: :user
  has_one_attached :picture
  has_many :comments, dependent: :destroy

  has_rich_text :content

  def liked_by?(user = nil)
    # Nếu user là nil,
    # phương thức sẽ trả về false ngay lập tức.
    # Điều này giúp đảm bảo rằng nếu không có người dùng nào được cung cấp, phương thức sẽ không thực hiện kiểm tra
    # và trả về false thay vì nil.
    return if user.nil?
    # Sử dụng phương thức include? để kiểm tra xem user có nằm trong danh sách liked_user hay không.
    liked_users.include?(user)
  end
  include PgSearch::Model

  pg_search_scope :search_by_title_and_content,
    against: [ :title, :content ],
    using: {
      tsearch: { prefix: true } # Cho phép tìm kiếm từ khóa không cần chính xác hoàn toàn
    }
end
