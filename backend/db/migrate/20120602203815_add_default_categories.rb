class AddDefaultCategories < ActiveRecord::Migration
  def up
    c_exp = Category.new :category_name => 'Expenses'
    c_exp.save!

    c_inc = Category.new :category_name => 'Income'
    c_inc.save!

    c_tax = Category.new :category_name => 'Tax', :parent_category_id => c_exp.id
    c_tax.save!

    c_sales = Category.new :category_name => 'Sales', :parent_category_id => c_inc.id
    c_sales.save!
  end

  def down
  end
end
