class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]


  def index
    if params[:search].present?
      @products = Product.search(params[:search]).records.to_a
      # .records will return the Rails Active Record Objects rather than Elastic Search objects (return by .results method)
      # .to_a will convert those all objects into an array and will assign it to the @products instance variable. 
    else
      @products = Product.all
    end
  end

  def show
  end

  def new
    @product = Product.new
  end


  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end
    def product_params
      params.require(:product).permit(:name, :price, :description, :photo)
    end
end
