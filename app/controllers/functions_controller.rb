class FunctionsController < ApplicationController
  before_action :set_function, only: [:show, :edit, :update, :destroy]

  # GET /functions
  # GET /functions.json
  def index
    @functions = Function.all
  end

  # GET /functions/1
  # GET /functions/1.json
  def show
    @function = Function.find(params[:id])
    @products = @function.products
  end

  # GET /functions/new
  def new
    @function = Function.new
    @product = Product.all
  end

  # GET /functions/1/edit
  def edit
    @function = Function.find(params[:id])
    @product = Product.all
  end

  # POST /functions
  # POST /functions.json
  def create
    @function = Function.new(function_params)
    params[:product_id] ||= []
    @product = Product.find(params[:product_id])
    respond_to do |format|
      if @function.save
        @function.products << @product
        format.html { redirect_to @function, notice: 'Function was successfully created.' }
        format.json { render :show, status: :created, location: @function }
      else
        format.html { render :new }
        format.json { render json: @function.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /functions/1
  # PATCH/PUT /functions/1.json
  def update
    params[:product_id] ||= []
    @product = Product.find(params[:product_id])
    respond_to do |format|
      @function.products.where(!@product).destroy_all
      if @function.update(function_params)
        @product.each do |p|
          if !@function.products.include?(p)
            @function.products << p
          end
        end
        format.html { redirect_to @function, notice: 'Function was successfully updated.' }
        format.json { render :show, status: :ok, location: @function }
      else
        format.html { render :edit }
        format.json { render json: @function.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /functions/1
  # DELETE /functions/1.json
  def destroy
    @function.destroy
    respond_to do |format|
      format.html { redirect_to functions_url, notice: 'Function was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_function
      @function = Function.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def function_params
      params.require(:function).permit(:name)
    end
end
