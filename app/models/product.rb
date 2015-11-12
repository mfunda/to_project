class Product < ActiveRecord::Base
	has_and_belongs_to_many :functions
	belongs_to :user
	validates :name, length: { maximum: 20},
					 presence: true	
end
