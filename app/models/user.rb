class User < ApplicationRecord
	has_many :posts, dependent: :destroy 
  has_many :likes
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed  
  has_many :followers, through: :passive_relationships, source: :follower
	attr_accessor :remember_token 
	validates :name, presence: true
	validates :mob, presence: true, numericality: true, length: { is: 10}, uniqueness: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 } 

	 def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.newtoken
  	SecureRandom.urlsafe_base64
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?other_user
  end
     



  def remember
  	self.remember_token = User.newtoken
  	update_attribute(:remember_digest, User.digest(remember_token))
  	end

  	def authenticated?
  		return false if remember_digest.nil?
  		BCrypt::Password.new(remember_digest).is_password?(remember_token)
  	end

  	def forget
  		update_attribute(:remember_digest, nil)
  	end

def feed

  following_ids = "SELECT followed_id FROM relationships
                     WHERE  follower_id = :user_id"
    Post.where("user_id IN (#{following_ids})
                     OR user_id = :user_id", user_id: id)
end
end
