# frozen_string_literal: true

class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  def quantity
    puts 'see quantity in order_product.rb'
  end

  def subtotal
    puts 'see subtotal in order_product.rb'
  end
end
