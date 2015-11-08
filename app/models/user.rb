class User < ActiveRecord::Base
	has_many :products, dependent: :destroy
	validates :name, length: {maximum: 15},
					 presence: true
	validates :surname, length: {maximum: 15},
					 presence: true


end
