class AddStausFromCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :status, :string, :default => "available"
  end
end
