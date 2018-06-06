class User < ApplicationRecord
	validates :name, presence: true
	validates :mob, presence: true, numericality: true, length: { is: 10}, uniqueness: true
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 } 
end
