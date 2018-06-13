class AddPrivacyToPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :posts, :privacy, :string
  end
end
