class Task < ActiveRecord::Base
	has_many :operations

	def set_task
		if self.id != nil
			@task = Task.find(self.id)
		else
			@task = Task.new
		end
	end

	def search(from, to)
 		self.set_task
		@time = @task.task_end
		if @time >= from.to_s && @time <= to.to_s
			true
		else
			false
		end
 	end

	def set_status
		self.set_task
		if DateTime.now > @task.task_end
			status = "Finished"
		elsif DateTime.now > @task.start && DateTime.now < @task.task_end
			status = "In progress"
		else
			status = "Not started yet"
		end
	end

	def total_duration
		self.set_task
		@operations = @task.operations
		total = 0
		@operations.each do |o|
			if o.duration != nil
				total = total+o.duration
			end
		end
		total
	end

	def total_rate
		self.set_task
		@operations = @task.operations
		total = 0
		@operations.each do |o|
			if o.duration && o.rate != nil
				total = total + o.rate*o.duration/60
			end
		end
		total	
	end

	def total_user_rate
		self.set_task
		@operations =@task.operations
		total = 0
		@operations.each do |o|
			total = total + o.total_users_rate
		end
		total
	end

	def total_task_rate
		self.set_task
		@operations = @task.operations
		cost = 0
		@operations.each do |o|
			cost = cost +o.total_users_rate
		end
		cost = cost + @task.total_rate
	end

	def total_users_average_rate
		self.set_task
		@operations = @task.operations
		total = 0
		@operations.each do |o|
			total = total + o.users_average_rate
		end
		if @operations.count != 0
			total = total/@operations.count
		else
			total
		end
	end

	def average_cost
		self.set_task
		if @task.operations.count != 0
			total = @task.total_rate/@task.operations.count
		else
			@task.total_rate
		end
	end 

	def average_total
		self.set_task
		if @task.operations.count != 0
			total = @task.total_task_rate/@task.operations.count
		else
			@task.total_task_rate
		end
	end

	def task_end
		finish = self.start + self.total_duration
	end
end
