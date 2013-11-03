class Account < ActiveRecord::Base
  attr_accessible :balance, :currency, :exchangeRate, :memo

  has_many :account_trans
end
