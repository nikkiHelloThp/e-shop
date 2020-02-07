# frozen_string_literal: true

class OrderProductsController < ApplicationController
  def create
    @order = current_order
    @order_product = @order.order_products.new(order_item_params)
    @order.save
    session[:cart] = @order.id
  end

  def destroy
    @order = current_order
    @order_product = @order.order_products.find(params[:id])
    @order_product.destroy
    redirect_to cart_path
  end

  private

  def order_item_params
    params.require(:order_product).permit(:product_id)
  end
end
