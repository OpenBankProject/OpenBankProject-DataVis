class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions do |t|
      t.primary_key :TransactionID
      t.float :Amount
      t.string :Currency

      t.timestamps
    end
  end

  def self.down
    drop_table :transactions
  end
end
