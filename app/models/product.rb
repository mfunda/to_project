class Product < ActiveRecord::Base
	before_save :total

	has_and_belongs_to_many :functions
	belongs_to :user
	validates :name, length: { maximum: 20},
					 presence: true	
	validates :price, presence: true

	def total
		if self.id != nil
			@product = Product.find(self.id)
		else
			@product = Product.new
		end
		total=1
		@function = @product.functions
		@function.each do |f|
			if f.factor != nil
				total = total*f.factor
			end
		end
		if @product.price != nil
			total = total*@product.price
		end
		total
	end
end
