class HistoriesController < ApplicationController

	def index
		@ta = Task.all
		@tasks = []
		@operations = []
		@users = []
		@cost = 0
		@users_cost = 0
		@operations_cost = 0
		@ta.each do |t|
			if t.set_status == "Finished"
				@tasks.append(t)
				t.operations.each do |o|
					o.total_duration = o.duration
					o.count = 1
					if !@operations.find{ |i| (i.total_duration+=o.total_duration) && (i.count += 1) if i[:name] == o.name && i != o}
						@operations.append(o)
					end
					o.users.each do |u|
						if !@users.include?(u)
							@users.append(u)
							u.total_user_cost = u.rate*o.total_duration/60
						end
					end
				end
			end
		end
		@tas =[]
		@op = []
		@us = []
		if params[:from] != "" && params[:to] != "" && params[:from] && params[:to]
			@tasks.each do |t|
				if t.search(params[:from], params[:to])
					@tas.append(t)
					t.operations.each do |o|
						o.total_duration = o.duration
						if !@op.find{ |i| i.total_duration+=o.total_duration if i[:name] == o.name && i != o}
							@op.append(o)
						end
						o.users.each do |u|
							if !@us.include?(u)
								@us.append(u)
								u.total_user_cost = u.rate*o.total_duration/60
							end
						end
					end
				end
			end
		@tasks = @tas
		@operations = @op
		@users = @us
		end
		@tasks.each do |t|
	      if t.total_task_rate && t.total_user_rate && t.total_rate
	        @cost += t.total_task_rate
	        @users_cost += t.total_user_rate
	        @operations_cost += t.total_rate
	      end
	    end
	end

	def show
		@task = Task.find(params[:id])
	end

	private
		def history_params
			params.require(:task).permit(:name, :start)
		end
end
