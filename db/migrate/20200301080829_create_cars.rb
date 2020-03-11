class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :year
      t.string :color
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :cars, [:user_id, :created_at]
  end
end
