class AddTransactionPartnerIdToTransaction < ActiveRecord::Migration
  def change
    add_column :transactions, :transaction_partner_id, :integer
  end
end
