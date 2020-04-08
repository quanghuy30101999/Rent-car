class RenameToUsers < ActiveRecord::Migration[5.1]
  def change
    rename_column :users, :sex, :gender
  end
end
