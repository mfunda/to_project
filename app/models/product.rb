class Product < ActiveRecord::Base
	belongs_to :user
	validates :name, length: { maximum: 20}
					 presence: true	
end
