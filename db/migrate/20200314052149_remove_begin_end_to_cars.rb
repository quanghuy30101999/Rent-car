class RemoveBeginEndToCars < ActiveRecord::Migration[5.1]
  def change
    remove_column :cars, :begin
    remove_column :cars, :end
  end
end
