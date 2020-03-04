# frozen_string_literal: true

class Product < ApplicationRecord

	before_validation :set_slug, on: [:create, :update]

  has_many :order_products
  has_many :orders, through: :order_products

  has_one_attached :image

  belongs_to :category

  validates_presence_of :slug

  def self.popular
  	products = OrderProduct.group(:product_id).sum(:quantity)
		ids = products.sort_by {|k,v| v}.reverse.map(&:first)
		where(id: ids).order_by_ids(ids)
  end

  def self.order_by_ids(ids)
	  order_by = ["case"]
	  ids.each_with_index.map do |id, index|
	    order_by << "WHEN id='#{id}' THEN #{index}"
	  end
	  order_by << "end"
	  order(order_by.join(" "))
	end

	def to_param
		slug
	end


	private

	def set_slug
		self.slug = title.parameterize
	end

end
