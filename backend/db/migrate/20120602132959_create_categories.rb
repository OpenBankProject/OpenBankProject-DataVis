class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.primary_key :CategoryID
      t.string :CategoryName
      t.integer :ParentCategoryID
      t.string :Type

      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
