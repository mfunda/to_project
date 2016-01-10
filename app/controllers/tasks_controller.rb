class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    @cost = 0
    @users = 0
    @operations = 0 
    @tasks.each do |t|
      if t.total_task_rate && t.total_user_rate && t.total_rate
        @cost += t.total_task_rate
        @users += t.total_user_rate
        @operations += t.total_rate
      end
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])
    @operations = @task.operations
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @operation = Operation.all
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @operation = Operation.all
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(task_params)
    params[:operation_id] ||= []
    @operation = Operation.find(params[:operation_id])
    respond_to do |format|
      if @task.save
        @task.operations << @operation
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render :show, status: :created, location: @task }
      else
        format.html { render :new }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tasks/1
  # PATCH/PUT /tasks/1.json
  def update
    params[:operation_id] ||= []
    @operation = Operation.find(params[:operation_id])
    @taskop = @task.operations        
     respond_to do |format|
      @taskop.each do |t|
        if !@operation.include?(t)
          t.task_id = nil
          t.save
        end
      end
      @task.operations << @operation
      if @task.update(task_params)
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { render :show, status: :ok, location: @task }
      else
        format.html { render :edit }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: 'Task was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def task_params
      params.require(:task).permit(:name, :start)
    end
end
