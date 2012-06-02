class CreateTransactionDates < ActiveRecord::Migration
  def change
    create_table :transaction_dates do |t|
      t.integer :day
      t.integer :month
      t.integer :year

      t.timestamps
    end
  end
end
