class Post < ApplicationRecord
  belongs_to :user
  has_many :likes
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader


  def not_liked?(user)
    likes.find_by(user_id: user.id).nil?
  end
 
end
