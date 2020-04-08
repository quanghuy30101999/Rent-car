class AddOrderTypeToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :order_type, :string, default: "NEW_ORDER"
    add_column :orders, :relation_orders, :integer
  end
end
