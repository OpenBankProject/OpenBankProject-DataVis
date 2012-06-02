class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.timestamps
      t.string :transaction_uuid
    end
  end
end
