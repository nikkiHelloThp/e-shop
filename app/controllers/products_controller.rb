class ProductsController < ApplicationController
  def show
  	@product = Product.find_by_slug(params[:id])
  	@products = Product.all.sample(4)
  	@order_product = current_order.order_products.new
  end
end
