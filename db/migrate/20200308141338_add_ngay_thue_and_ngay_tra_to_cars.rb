class AddNgayThueAndNgayTraToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :NgayThue, :datetime
    add_column :cars, :NgayTra, :datetime
  end
end
