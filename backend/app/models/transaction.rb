class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :transaction_date

  attr_accessible :account_holder, :amount
end
