class AdddBeginEndToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :begin, :datetime
    add_column :cars, :end, :datetime
  end
end
