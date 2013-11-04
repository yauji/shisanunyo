class TradeLog < ActiveRecord::Base
  attr_accessible :basicPrice, :buyValueForeign, :buyValueJPY, :date, :dividendValueForeign, :dividendValueJPY, :noItem, :sellValueForeign, :sellValueJPY, :type, :memo
  
  belongs_to :unfixIssue,  :foreign_key => "base_issue_id"
  # belongs_to :unfixIssue, :class_name => "BaseIssue", :foreign_key => "base_issue_id"
  # belongs_to :baseIssue, :foreign_key => "base_issue_id"
end
