class AddTestTransactions < ActiveRecord::Migration
  def up
    c_exp = Category.find_by_category_name("Expenses")
    c_inc = Category.find_by_category_name("Income")

    c_sales = Category.new :category_name => "Sales", :parent_category_id => c_inc.id
    c_sales.save!

    c_tax = Category.new :category_name => "Tax", :parent_category_id => c_exp.id
    c_tax.save!

    t1 = Transaction.new :account_holder => 'Finanzamt',
                         :amount => -50
    t1.category = c_tax
    t1.save!

    t2 = Transaction.new :account_holder => 'Finanzamt #2',
                         :amount => -30
    t2.category = c_tax
    t2.save!


    t3 = Transaction.new :account_holder => 'Our biggest client',
                         :amount => 5000
    t3.category = c_sales
    t3.save!

    t4 = Transaction.new :account_holder => 'Another client',
                         :amount => 1000
    t4.category = c_sales
    t4.save!

  end

  def down
  end
end
