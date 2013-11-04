class BaseIssue < ActiveRecord::Base
  attr_accessible :baseCurrency, :name, :principalForeign, :principalJPY, :status, :memo

end

class FixIssue < BaseIssue
  attr_accessible :date, :endDate, :valueJPY,:valueForeign, :exchangeRate, :interestRate, :duration
end

class UnfixIssue < BaseIssue
  attr_accessible :noItem

  has_many :tradeLogs, :foreign_key => "base_issue_id"
end


