# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  def total
  	order_products.collect {|order_product| order_product.product.price}.sum
  end

  def total_in_cent
  	(self.total*100).to_i
  end
end
