class AddBalanceColumnToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :balance, :string
  end
end
