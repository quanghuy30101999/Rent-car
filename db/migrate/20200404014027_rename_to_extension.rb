class RenameToExtension < ActiveRecord::Migration[5.1]
  def change
    add_column :extension_orders, :rent_time, :datetime
  end
end
