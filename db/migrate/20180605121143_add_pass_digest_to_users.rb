class AddPassDigestToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :pass_digest, :string
  end
end
