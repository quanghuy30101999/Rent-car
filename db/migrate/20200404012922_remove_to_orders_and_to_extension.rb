class RemoveToOrdersAndToExtension < ActiveRecord::Migration[5.1]
  def change
    remove_column :orders, :order_type
    remove_column :orders, :relation_orders
    remove_column :extension_orders, :phone
    remove_column :extension_orders, :type_order
    rename_column :extension_orders, :request_date, :return_time
  end
end
