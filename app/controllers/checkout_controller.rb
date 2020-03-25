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
  			quantity: 1,
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
    order.update_attribute(paid: true)
    @order_products = order.order_products
    cookies.delete(:cart)
    UserMailer.with(user: current_user).order_email.deliver_now
    UserMailer.with(admin: User.find_by(admin: true)).admin_order_email.deliver_now
  end

  def cancel
  end
end
