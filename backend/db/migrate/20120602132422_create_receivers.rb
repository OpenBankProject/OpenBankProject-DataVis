class CreateReceivers < ActiveRecord::Migration
  def self.up
    create_table :receivers do |t|
      t.primary_key :ReceiverID
      t.string :name
      t.string :alias
      t.integer :BankAccountNumber
      t.string :OpenCorporateURL

      t.timestamps
    end
  end

  def self.down
    drop_table :receivers
  end
end
