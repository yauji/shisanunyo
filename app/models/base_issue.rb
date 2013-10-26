class BaseIssue < ActiveRecord::Base
  attr_accessible :baseCurrency, :name, :principalForeign, :principalJPY, :status
end

class FixIssue < BaseIssue
  attr_accessible :date, :endDate, :valueJPY,:valueForeign, :exchangeRate, :interestRate, :duration
end

class UnfixIssue < BaseIssue
  attr_accessible :noItem

  has_many :trade_logs
end


