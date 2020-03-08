# frozen_string_literal: true

class Product < ApplicationRecord

	before_validation :set_slug, on: [:create, :update]

  has_many :order_products
  has_many :orders, through: :order_products

  has_one_attached :image

  belongs_to :category

  validates_presence_of :slug
  
  # def method(id, **json)
  # 	find(id).map{|p| [p.title, p.price, order_product.qty, p.price*order_product.qty]}
  # end
  # multiple_args(*arg)
  

		# products = OrderProduct.group(:product_id).sum(:quantity)
		# ids = products.sort_by {|k,v| v}.reverse.map(&:first)
		# find(ids.take(5))

  def self.popular
		product_sum = OrderProduct.group(:product_id).sum(:quantity)
		product = product_sum.map{|k| k[0]}
		qty = product_sum.map{|k| k[1]}
		products = Product.find(product)
		arr1 = products.map{|e| [e.title, e.price]}
		arr2 = arr1.each{|e| e << qty.shift()}
		arr3 = arr2.each{|e| e << (e[1]*e[2]).to_i}
		arr3.each{|e| e}
  end

	def to_param
		slug
	end


	private

	def set_slug
		self.slug = title.parameterize
	end

end
