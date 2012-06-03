class AddTransactionUuidToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_uuid, :string
  end
end
