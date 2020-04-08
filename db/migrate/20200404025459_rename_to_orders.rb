class RenameToOrders < ActiveRecord::Migration[5.1]
  def change
    rename_column :orders, :orders_status, :status
  end
end
