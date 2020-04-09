class RemoveLastUpdateToOrders < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :last_update
  end
end
