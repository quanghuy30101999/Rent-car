class BeginEndStatusFromCars < ActiveRecord::Migration[5.1]
  def change
    remove_column :cars, :begin
    remove_column :cars, :end
    remove_column :cars, :status
  end
end
