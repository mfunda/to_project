class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @products = Product.find(params[:id])
    @functions = @product.functions
  end

  # GET /products/new
  def new
    @product = Product.new
    @function = Function.all
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @function = Function.all
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    params[:function_id] ||= []
    @function = Function.find(params[:function_id])
    respond_to do |format|
      if @product.save
        @product.functions << @function
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    params[:function_id] ||= []
    @function = Function.find(params[:function_id])
    respond_to do |format|
      @product.functions.where(!@function).destroy_all
      if @product.update(product_params)
          @function.each do |f|
            if !@product.functions.include?(f)
              @product.functions << f
            end
        end
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :user_id)
    end
end
