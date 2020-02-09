module Admin::ProductsHelper
	def authenticate_admin
		redirect_to root_path if !current_user.admin
	end
end
