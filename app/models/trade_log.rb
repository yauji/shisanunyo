class TradeLog < ActiveRecord::Base
  attr_accessible :basicPrice, :basicPriceForeign, :buyValueForeign, :buyValueJPY, :date, :dividendValueForeign, :dividendValueJPY, :noItem, :sellValueForeign, :sellValueJPY, :tradeType, :memo
  
  belongs_to :unfixIssue,  :foreign_key => "base_issue_id"
  
  #validation
  validates_presence_of :date, :message => "is mandatory."
end
