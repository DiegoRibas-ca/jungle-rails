class ProductsController < ApplicationController

  
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    
    @product = Product.includes(:reviews).find params[:id]
    # @reviews = @product.reviews
  end

end
