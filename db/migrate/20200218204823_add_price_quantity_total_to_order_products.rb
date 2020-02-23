class AddPriceQuantityTotalToOrderProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :order_products, :unit_price, :float
    add_column :order_products, :quantity, :integer, default: 1
    add_column :order_products, :total_price, :float
  end
end
