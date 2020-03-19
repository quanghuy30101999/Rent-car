class AddOrdersStatusToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :orders_status, :string, default: "requesting"
  end
end
