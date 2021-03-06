class Admin::ProductsController < ApplicationController
	include Admin::ProductsHelper
	before_action :authenticate_admin
	before_action :set_product, only: [:show, :edit, :update, :destroy]

	def index
		@products = Product.includes(:category).all
	end

	def show
	end

	def new
		@product = Product.new
	end

	def create
		@product = Product.create(product_params)
		if @product.save
			redirect_to @product
		else
			render 'new'
		end
	end

	def edit
	end

	def update
		if @product.update(product_params)
			redirect_to @product
		else
			render 'edit'
		end
	end

	def destroy
		@product.destroy
		redirect_to admin_products_path
	end


	private

	def set_product
		@product = Product.find_by_slug(params[:id])
	end

	def product_params
		params.require(:product).permit(:title, :description, :price, :image, :category_id)
	end
end
