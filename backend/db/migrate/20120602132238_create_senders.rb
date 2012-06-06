class CreateSenders < ActiveRecord::Migration
  def self.up
    create_table :senders do |t|
      t.string :SenderID
      t.string :name
      t.string :alias
      t.integer :BankAccountNumber
      t.string :OpenCorporateURL

      t.timestamps
    end
  end

  def self.down
    drop_table :senders
  end
end
