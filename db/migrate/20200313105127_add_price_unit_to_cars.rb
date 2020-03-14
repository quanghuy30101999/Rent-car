class AddPriceUnitToCars < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :price_unit, :string, default: "VND"
  end
end
