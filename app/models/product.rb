# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :order_products
  has_many :orders, through: :order_products

  has_one_attached :image

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

end
