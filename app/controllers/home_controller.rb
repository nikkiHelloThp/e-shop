# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    @products = Product.all
    @order_product = current_order.order_products.new
  end

  def orders
  	@orders = Order.where(user: current_user).where(paid: true).includes(:products)
  end
end
