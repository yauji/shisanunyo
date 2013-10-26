class AccountTran < ActiveRecord::Base
  attr_accessible :date, :expenditure, :income, :memo
end
