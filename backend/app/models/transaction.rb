class Transaction < ActiveRecord::Base
  belongs_to :category
  belongs_to :transaction_date
  belongs_to :transaction_partner
  attr_accessible :account_holder, :amount
end
