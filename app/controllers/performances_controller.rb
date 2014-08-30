class PerformancesController < ApplicationController
  # GET /fix_issues
  # GET /fix_issues.json
  def index
    # calculate sum of principal -----
    @principal = 0
    
    # fix issue
    fis = FixIssue.find(:all, 
      :conditions => {
        # :status => IssueStatus::ACTIVE,
        :principalCurrency => Currency::JPY}
        )
        
    fis.each do |fi|
      @principal += fi.principalJPY
    end
    
    
    
    # trade log
    # tls = TradeLog.find(:all,
      # :conditions => ['buyValueJPY NOT ?', nil]
    # )
    tls = TradeLog.find(:all)
    
    tls.each do |tl|
      unless tl.buyValueJPY.nil? then
        @principal += tl.buyValueJPY
      end
    end


    #calculate value------------
    @value = 0
    
    # fix issue
    vfis = FixIssue.find(:all 
      )
        
    vfis.each do |fi|
      if fi.status == IssueStatus::ACTIVE then
        unless fi.principalJPY.nil? then
          @value += fi.principalJPY  
        else
          #TODO treat in case that there are no account corresponding to currency
          @value += fi.principalForeign * getRate(fi.baseCurrency)
        end
      else
        unless fi.valueJPY.nil? then
          @value += fi.valueJPY
        end
      end
    end
    
    
    
    # unfix issue
    vuis = UnfixIssue.find(:all)
        
    vuis.each do |ui|
      #get basic price
      tl = ui.tradeLogs.last
      
      
      rate = 1
      
      if ui.baseCurrency != Currency::JPY then
        hyokagaku = tl.basicPriceForeign * ui.noItem
        rate = getRate(ui.baseCurrency)
      else
        hyokagaku = tl.basicPrice * ui.noItem
      end
      
      @value += hyokagaku * rate
      
=begin      
      unless ui.principalJPY.nil? then
        @value += ui.principalJPY  
      else
          #TODO check
        @value += ui.principalForeign * getRate(ui.baseCurrency)
      end
=end      
    end
    
    #account
    account = Account.find(:all)
    
    account.each do |a|
      unless a.balance.nil? then
        @value += a.balance * getRate(a.currency) 
      end
      
    end
    
    
    #trade log
    tl = TradeLog.find(:all)
    
    tl.each do |t|
      unless t.sellValueJPY.nil? then
        @value += t.sellValueJPY
      end
      unless t.dividendValueJPY.nil? then
        @value += t.dividendValueJPY
      end
    end
    
    
#    @value -= @principal
    
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  # return currency rate from account info
  def getRate currency
    accounts = Account.find(:all)
    
    accounts.each do |a|
      if a.currency == currency then
        return a.exchangeRate
      end
    end
  end
  
end
