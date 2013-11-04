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
    

    
    @value = 100
    
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end
end
