class AddTimeUserUpdateToOrders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :last_update, :datetime
  end
end
