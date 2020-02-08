class CheckoutController < ApplicationController
  def create
  	order = current_order

  	@session = Stripe::Checkout::Session.create(
  		payment_method_types: ['card'],
  		line_items: [{
  			name: 'Eshop products',
  			description: "payment of order : #{order.id}",
  			amount: order.total_in_cent,
  			currency: 'eur',
  			quantity: order.order_products.size,
			}],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url,
  	)

  	respond_to do |format|
  		format.js
  	end
  end

  def success
    order = current_order
    @order_products = order.order_products
    session[:cart] = nil
  end

  def cancel
  end
end
