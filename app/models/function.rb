class Function < ActiveRecord::Base
	has_and_belongs_to_many :products
	validates :factor, presence: true
end
