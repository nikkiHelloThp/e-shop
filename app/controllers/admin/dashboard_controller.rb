class Admin::DashboardController < ApplicationController
  def index
  	@customers = User.where(admin: false).count
  	@orders = Order.where(paid: true)
  	@order_count = Order.where(paid: true).count
  	@revenue = @orders.pluck(:total)
  	@revenue_sum = @revenue.sum
  	@total_sales = @revenue_sum
  	@average_sale_size = 
  		@total_sales>0 ? @total_sales/@revenue.size : 0
  	# @growth = (present_revenue-past_revenue)*100/past_revenue
  	# @top_selling_products =
  		# products.sort_by(price * quantity).take(5)
  end
end
