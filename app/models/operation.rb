class Operation < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to :task
	attr_accessor :total_duration, :count, :average

	def set_operation
		if self.id != nil
			@operation = Operation.find(self.id)
		else
			@operation = Operation.new
		end
	end

	def total_users_rate
		self.set_operation
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
		self.set_operation
		total = @operation.rate*@operation.duration/60
	end

	def total_operation_cost
		self.set_operation
		total = @operation.total_operation_rate + @operation.total_users_rate
	end

	def users_average_rate
		self.set_operation
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

	def same_operation_duration
		self.total_duration

	end

	def same_operation_average
		self.set_operation
		average = self.same_operation_total_cost/self.count 
	end

	def same_operation_total_cost
		self.set_operation
		total = @operation.rate*self.total_duration/60
	end

	def same_user_total_cost
		self.set_operation
		@users = @operation.users
		@users.each do |u|
			total += u.rate*self.total_duration/60
		end
		total
	end

end
