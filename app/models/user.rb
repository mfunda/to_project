class User < ActiveRecord::Base
	has_many :products
	validates :name, length: {maximum: 15},
					 presence: true
	validates :surname, length: {maximum: 15}	
					 presence: true
end
