class Operation < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :task

	def total_users_rate
		if self.id != nil
			@operation = Operation.find(self.id)
		else
			@operation = Operation.new
		end
		@users = @operation.users
		total = 0
		@users.each do |u|
			if u.rate != nil
				total = total + u.rate*@operation.duration/60
			end
		end
		if @users.count != 0
			total = total/@users.count
		else
			total
		end
	end

	def total_operation_rate
		if self.id != nil
			@operation = Operation.find(self.id)
		else
			@operation = Operation.new
		end
		total = @operation.rate*@operation.duration/60
	end

	def total_operation_cost
		if self.id != nil
			@operation = Operation.find(self.id)
		else
			@operation = Operation.new
		end
		total = @operation.total_operation_rate + @operation.total_users_rate
	end

	def users_average_rate
		if self.id != nil
			@operation = Operation.find(self.id)
		else
			@operation = Operation.new
		end
		@users =  @operation.users
		total = 0
		@users.each do |u|
			total = total + u.rate
		end
		if @users.count != 0
			total = total/@users.count
		else
			total
		end
	end
end
