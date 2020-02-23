class ProductsController < ApplicationController
  def show
  	@product = Product.find(params[:id])
  	@products = Product.all.sample(4)
  	@order_product = current_order.order_products.new
  end
end
