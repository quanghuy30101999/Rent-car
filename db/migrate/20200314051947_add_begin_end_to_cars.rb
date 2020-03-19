class AddBeginEndToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :begin, :date
    add_column :cars, :end, :date
  end
end
