class AddCategoryIdToTransaction < ActiveRecord::Migration
  def up
    add_column :transactions, :category_id, :integer
  end

  def down
    remove_column :transactions, :category_id
  end
end
