class AddCheckToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :check, :boolean, default: false
  end
end
