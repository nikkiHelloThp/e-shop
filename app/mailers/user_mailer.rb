class UserMailer < ApplicationMailer
	default from: 'no-reply@myfakeshop.com'

	def welcome_email
		@user = params[:user]
		@url = 'http://myfakeshop.com/login'
		mail(to: @user.email, subject: 'Welcome to Eshop !')
	end

	def order_email
		@user = params[:user]
		mail(to: @user.email, subject: 'Order confirmed !')
	end
end
