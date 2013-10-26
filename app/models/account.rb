class Account < ActiveRecord::Base
  attr_accessible :balance, :currency, :exchangeRate

  has_many :account_trans
end
