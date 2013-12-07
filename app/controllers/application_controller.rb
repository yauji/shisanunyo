class ApplicationController < ActionController::Base
  protect_from_forgery
  
  module IssueStatus
    ACTIVE = 'active'
    FINISHED = 'finished'
  end

  module Currency
    JPY = 'JPY'
    USD = 'USD'
    AUD = 'AUD'
    EUR = 'EUR'
  end

  module TradeType
    BUY = 'buy'
    SELL = 'sell'
    DIVIDEND = 'dividend'
    
  end
end
