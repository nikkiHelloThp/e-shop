# frozen_string_literal: true

class Product < ApplicationRecord

	before_validation :set_slug, on: [:create, :update]

  has_many :order_products
  has_many :orders, through: :order_products

  has_one_attached :image

  belongs_to :category

  validates_presence_of :slug

  def self.popular
 		ordered_products = Product.joins(:order_products).group(:id)
 		ordered_products_sum = ordered_products.sum(:quantity)
 		ordered_products_quantities = ordered_products_sum.map{|k,v| v}
 		ordered_products.enum_for(:each_with_index)
 			.map{|e,i|
 				{
 					title: e[:title],
 					price: e[:price],
 					quantity: ordered_products_quantities[i],
 					total: e[:price]*ordered_products_quantities[i]
 				}
 			}
 		.take(5)
  end

	def to_param
		slug
	end


	private

	def set_slug
		self.slug = title.parameterize
	end

end
