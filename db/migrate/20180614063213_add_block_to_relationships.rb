class AddBlockToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :block, :integer, default: 0
  end
end
