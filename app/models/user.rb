class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes, source: :post, dependent: :destroy
  has_many :comments, dependent: :destroy
  validates_uniqueness_of :name
  has_one_attached :avatar
  before_validation :set_name
  # Enum để quản lý vai trò

  private
  def set_name
    if name.blank?
      self.name = "user_#{rand(100)}"
    end
  end
end
