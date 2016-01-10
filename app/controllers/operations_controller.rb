class OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :edit, :update, :destroy]

  # GET /operations
  # GET /operations.json
  def index
    @operations = Operation.all
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
    @operation = Operation.find(params[:id])
    @users = @operation.users
  end

  # GET /operations/new
  def new
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit
    @check = 1
    @operation = Operation.find(params[:id])
    @functions = Function.where({:name => @operation.name})
    @users = []
    @functions.each do |f|
      f.products.each do |p|
        if !@users.include?(User.find(p.user_id))
          @users.append(User.find(p.user_id))
        end    
      end
    end
  end

  # POST /operations
  # POST /operations.json
  def create
    @operation = Operation.new(operation_params)
    params[:user_id] ||= []
    @users = User.find(params[:user_id])
    respond_to do |format|
      if @operation.save
        @operation.users << @users
        format.html { redirect_to @operation, notice: 'Operation was successfully created.' }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1
  # PATCH/PUT /operations/1.json
  def update
    params[:user_id] ||= []
    @user = User.find(params[:user_id])
    respond_to do |format|
      @operation.users.where(!@user).destroy_all
      if @operation.update(operation_params)
        @operation.users << @user
        format.html { redirect_to @operation, notice: 'Operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.json
  def destroy
    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Operation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_operation
      @operation = Operation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def operation_params
      params.require(:operation).permit(:name, :rate, :duration, :task_id)
    end
end
