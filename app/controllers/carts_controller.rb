# frozen_string_literal: true

class CartsController < ApplicationController
  def show
  	@order = current_order
    @order_products = @order.order_products
  end
end
