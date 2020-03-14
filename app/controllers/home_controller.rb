# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @categories = Category.all
    category = params[:category]
    if !!category
    	@products = Product.where(category: category)
    else
    	@products = Product.all
    end
    @order_product = current_order.order_products.new
  end

  def orders
  	@orders = Order.where(user: current_user, paid: true).includes(:products)
  end
end
