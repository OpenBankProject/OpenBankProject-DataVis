class CreateTransactionDates < ActiveRecord::Migration
  def self.up
    create_table :transaction_dates do |t|
      t.primary_key :DateID
      t.date :Date

      t.timestamps
    end
  end

  def self.down
    drop_table :transaction_dates
  end
end
