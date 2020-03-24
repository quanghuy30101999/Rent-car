class AddColumnToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :phone, :integer
    add_column :users, :sex, :boolean
    add_column :users, :birthday, :date
    add_column :orders, :phone, :integer
    remove_column :orders, :name
    remove_column :orders, :email
  end
end
