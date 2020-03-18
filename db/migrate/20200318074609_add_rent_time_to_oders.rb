class AddRentTimeToOders < ActiveRecord::Migration[5.1]
  def change
    add_column :orders, :rent_time, :datetime
  end
end
