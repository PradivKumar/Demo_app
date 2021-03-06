class User < ApplicationRecord
	has_many :posts, dependent: :destroy 
  has_many :likes
  has_many :comments, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed  
  has_many :followers, through: :passive_relationships, source: :follower
	attr_accessor :remember_token 
  acts_as_voter
	validates :name, presence: true
	validates :mob, presence: true, numericality: true, length: { is: 10}, uniqueness: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 } 

 #privacy_opt = ['Following', 'Public', 'Private']

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
    following.include?other_user #&& Relationship.where(followed: other_user, block: 2).empty? #&& Relationship.where(followed: other_user, block: 2).empty?
  end
     
  def blocking?(user, other_user)
    user.active_relationships.where(followed: other_user, block: 1).present? || user.active_relationships.where(followed: other_user, block: 2).present?
  end

  def blocked?(user, other_user)
      user.active_relationships.where(followed: other_user, block: 2).present?
  end

    def block?(user, other_user)
      user.active_relationships.where(followed: other_user, block: 1).present?
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
                     WHERE  (follower_id = :user_id AND block = '0')"
 
  blocked_ids = "SELECT followed_id FROM relationships
                     WHERE  (follower_id = :user_id AND (block = '1' OR block = '2'))"

    Post.where("((user_id IN (#{following_ids})
                     AND user_id NOT IN (#{blocked_ids})) OR user_id = :user_id)", user_id: id)

end

def noti
  blocked_ids = "SELECT followed_id FROM relationships
                     WHERE  (follower_id = :user_id AND (block = '1' OR block = '2'))"
   following_ids = "SELECT followed_id FROM relationships
                     WHERE  (follower_id = :user_id AND block = '0')"

    #date = Time.now.strftime("%Y-%m-%d")

tdate = Date.today
    
    User.where("(id IN (#{following_ids}) AND id NOT IN (#{blocked_ids})) AND (dob = :date)", user_id: id, date: tdate)                 

end



def blocked_users
    blocked_ids = "SELECT followed_id FROM relationships
                     WHERE  (follower_id = :user_id AND (block = '1' OR block = '2'))"
    User.where("(id IN (#{blocked_ids}))", user_id: id)
end

def following_users
  following_ids = "SELECT followed_id FROM relationships
                     WHERE  (follower_id = :user_id AND block = '0')"
   User.where("(id IN (#{following_ids}))", user_id: id)                   
end

def follower_users
  follower_ids = "SELECT follower_id FROM relationships
                     WHERE  (followed_id = :user_id AND block = '0')"
User.where("(id IN (#{follower_ids}))", user_id: id)              
end

end
