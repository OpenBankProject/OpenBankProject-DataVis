class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category_type
      t.integer :parent_category_id
      t.string :category_name

      t.timestamps
    end
  end
end
