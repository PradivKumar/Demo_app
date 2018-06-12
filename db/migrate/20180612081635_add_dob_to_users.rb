class AddDobToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :dob, :date
  end
  add_index :users, :dob
end
