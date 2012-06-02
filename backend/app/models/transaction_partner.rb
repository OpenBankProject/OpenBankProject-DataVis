class TransactionPartner < ActiveRecord::Base
  has_many :transactions

  attr_accessible :account_holder, :bank_name
end
