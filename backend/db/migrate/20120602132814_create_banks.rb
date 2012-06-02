class CreateBanks < ActiveRecord::Migration
  def self.up
    create_table :banks do |t|
      t.primary_key :BankID
      t.string :BankName
      t.string :BIC

      t.timestamps
    end
  end

  def self.down
    drop_table :banks
  end
end
