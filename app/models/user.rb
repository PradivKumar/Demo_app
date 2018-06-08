class User < ApplicationRecord
	has_many :posts, dependent: :destroy 
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
end
