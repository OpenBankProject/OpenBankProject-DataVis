class CreateTableForDailyBalanceIncomeAndExpense < ActiveRecord::Migration
  def up
    create_table :daily_balance_income_expenses do |t|
      t.string :balance
      t.string :income
      t.string :expense

      t.timestamps
    end

  end

  def down
  end
end
