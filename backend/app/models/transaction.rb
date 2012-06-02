class Transaction < ActiveRecord::Base
  attr_accessible :account_holder, :amount
end
