class Admin::DashboardController < ApplicationController
  def index
  	@customers = User.where(admin: false).count
  	@orders = Order.where(paid: true)
  	@order_count = @orders.count
  	@revenue = @orders.pluck(:total)
  	@total_sales = @revenue.sum
  	@average_sale_size = 
  		@total_sales>0 ? @total_sales/@revenue.size : 0
  end
end
