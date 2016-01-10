class User < ActiveRecord::Base
	before_save :totals
	has_many :products, dependent: :destroy
	has_and_belongs_to_many :operations
	validates :name, length: {maximum: 15},
					 presence: true
	validates :surname, length: {maximum: 15},
					 presence: true

	def totals
		if self.id != nil
			@user = User.find(self.id)
		else
			@user = User.new
		end
		@product = @user.products
		total = 0
		@product.each do |p|
			if p.total != nil
				total = total+p.total
			end
		end
		if@product.count != 0
			totals = total/@product.count
		end
		self.average = totals
	end
end
