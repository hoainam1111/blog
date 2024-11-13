class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, dependent: :destroy

  validates_uniqueness_of :name

  before_validation :set_name

  private
  def set_name
    if name.blank?
      self.name = "user_#{rand(100)}"
    end
  end
end
