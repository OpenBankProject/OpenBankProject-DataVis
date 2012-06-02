class Transaction < ActiveRecord::Base
  belongs_to :category

  attr_accessible :account_holder, :amount
end
