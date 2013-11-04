require 'test_helper'

class FixIssuesControllerTest < ActionController::TestCase
  setup do
#    @base_issue = base_issues(:one)

    
  end
  
  test "should create fix_issue of JPY->Forign Currency" do
    # fis = FixIssue.find(:all)
    # p fis
    
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"jpy2fc", 
        "fix_issue"=>{"memo"=>"hoge", 
        "name"=>"AUD", 
        "principalJPY"=>"10000", 
        # "principalForeign"=>"", 
        "date(1i)"=>"2013", 
        # "duration"=>"", 
        "exchangeRate"=>"93", 
        "date(3i)"=>"3", 
        "date(2i)"=>"11", 
        # "interestRate"=>"", 
        "valueForeign"=>"930", 
        "valueJPY"=>"", "baseCurrency"=>"AUD"}
    end
    
    account = 
      Account.find(:first, :conditions => {:currency => "AUD"})
    assert_equal 930, account.balance
    
    # p account
    
    accountTrans =
      AccountTran.find(:all)
      
    # p account.account_trans
    # p accountTrans
      
       
    ufi = UnfixIssue.new
    ufi.save
    # p ufi
    
    # p ufi
    tl = TradeLog.new
    tl.unfixIssue = ufi
    # tl.baseIssue = ufi
    tl.save
    
    # ufi.save
    
    # p tl
    # p ufi
    
    p ufi.tradeLogs
    
    ufis = UnfixIssue.find(:all)  
    # p ufis 
    
    # p ufi
    # p ufi.tradeLogs
    
    tls = TradeLog.find(:all)
    # p tls
    
    p "------------------"
    ac = Account.new
    ac.save
    
    p ac
    
    act = AccountTran.new
    act.account = ac
    act.save
    
    p act
     
         
    # 
      # post :create, :base_issue => { :baseCurrency => @base_issue.baseCurrency, :date => @base_issue.date, :duration => @base_issue.duration, :endDate => @base_issue.endDate, :exchangeRate => @base_issue.exchangeRate, :interestRate => @base_issue.interestRate, :name => @base_issue.name, :noItem => @base_issue.noItem, :principalForeign => @base_issue.principalForeign, :principalJPY => @base_issue.principalJPY, :status => @base_issue.status, :valueForeign => @base_issue.valueForeign, :valueJPY => @base_issue.valueJPY }
    # end



    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

end
