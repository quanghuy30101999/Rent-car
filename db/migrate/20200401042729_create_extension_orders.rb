class CreateExtensionOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :extension_orders do |t|
      t.references :order, foreign_key: true
      t.integer :phone
      t.datetime :request_date
      t.string :status, default: "requesting"
      t.string :type_order, default: "EXTENSION_ORDER"
      t.timestamps
    end
    add_index :extension_orders, [:order_id, :created_at]
  end
end
