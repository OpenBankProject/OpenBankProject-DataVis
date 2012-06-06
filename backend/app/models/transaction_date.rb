class TransactionDate < ActiveRecord::Base
  has_many :transactions

  attr_accessible :day, :month, :year
end
