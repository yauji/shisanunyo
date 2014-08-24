class ApplicationController < ActionController::Base
  protect_from_forgery

  http_basic_authenticate_with name:ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD']
  
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

  # update balance
  # after specified date
  def updateAccountBalance (account)
    
    ats = AccountTran.where(account_id: account).order(:date)
#    p ats

    balance = 0
    ats.each do |at|
      if !at.income.nil? then
        balance += at.income
      end
      if !at.expenditure.nil? then
        balance -= at.expenditure
      end
    end

    account.update_attribute :balance, balance

  end

end
