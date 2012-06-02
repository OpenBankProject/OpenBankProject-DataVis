class AddTransactionDateIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_date_id, :integer
  end
end
