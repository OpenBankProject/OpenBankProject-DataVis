class CreateTransactionPartners < ActiveRecord::Migration
  def change
    create_table :transaction_partners do |t|
      t.string :account_holder
      t.string :bank_name

      t.timestamps
    end
  end
end
