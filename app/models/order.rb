# frozen_string_literal: true

class Order < ApplicationRecord
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  before_save :set_total

  def total
  	order_products.collect {|order_product| order_product.valid? ? (order_product.unit_price*order_product.quantity) : 0}.sum
  end

  def total_in_cent
  	(self.total*100).to_i
  end


  private

  def set_total
  	self[:total] = total
  end
end
