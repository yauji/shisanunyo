class BaseIssue < ActiveRecord::Base
  attr_accessible :baseCurrency, :date, :duration, :endDate, :exchangeRate, :interestRate, :name, :noItem, :principalForeign, :principalJPY, :status, :valueForeign, :valueJPY
end
