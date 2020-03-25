# frozen_string_literal: true

class OrderProductsController < ApplicationController
  before_action :set_order
  before_action :set_product, only: [:update, :destroy]
  
  def create
    @order_product = @order.order_products.new(order_item_params)
    @order.save
    cookies[:cart] = @order.id
  end

  def update
    @order_product.update_attributes(order_item_params)
    redirect_to cart_path
  end

  def destroy
    @order_product.destroy
    redirect_to cart_path
  end

  private

  def set_order
    @order = current_order
  end

  def set_product
    @order_product = @order.order_products.find(params[:id])
  end

  def order_item_params
    params.require(:order_product).permit(:product_id, :quantity)
  end
end
