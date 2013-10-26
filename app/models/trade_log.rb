class TradeLog < ActiveRecord::Base
  attr_accessible :basicPrice, :buyValueForeign, :buyValueJPY, :date, :dividendValueForeign, :dividendValueJPY, :noItem, :sellValueForeign, :sellValueJPY, :type
end
