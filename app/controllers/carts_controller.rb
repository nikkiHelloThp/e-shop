# frozen_string_literal: true

class CartsController < ApplicationController
  def show
    @order_products = current_order.order_products
  end
end
