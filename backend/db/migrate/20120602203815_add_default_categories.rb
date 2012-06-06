class AddDefaultCategories < ActiveRecord::Migration
  def up
    c_exp = Category.new :category_name => 'Expenses'
    c_exp.save!

    c_inc = Category.new :category_name => 'Income'
    c_inc.save!
  end

  def down
  end
end
