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
        "fix_issue"=>{
           "principalCurrency"=>"JPY",
           "baseCurrency"=>"AUD",
           "memo"=>"hoge", 
        "name"=>"AUD", 
        "principalJPY"=>"10000", 
        # "principalForeign"=>"", 
        # "duration"=>"", 
        "exchangeRate"=>"93", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"11", 
        "date(3i)"=>"3", 
        # "interestRate"=>"", 
        "valueForeign"=>"930", 
        "valueJPY"=>"",
         }
    end
    
    account = 
      Account.find(:first, :conditions => {:currency => "AUD"})
    assert_equal 930, account.balance
    
    assert_equal 1, account.account_trans.count
    
    # p account
=begin   
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
=end  
         
    # 
      # post :create, :base_issue => { :baseCurrency => @base_issue.baseCurrency, :date => @base_issue.date, :duration => @base_issue.duration, :endDate => @base_issue.endDate, :exchangeRate => @base_issue.exchangeRate, :interestRate => @base_issue.interestRate, :name => @base_issue.name, :noItem => @base_issue.noItem, :principalForeign => @base_issue.principalForeign, :principalJPY => @base_issue.principalJPY, :status => @base_issue.status, :valueForeign => @base_issue.valueForeign, :valueJPY => @base_issue.valueJPY }
    # end



    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

  test "should create fix_issue of Forign Currency -> JPY" do
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"fc2jpy", 
        "fix_issue"=>{ 
           "principalCurrency"=>"AUD",
           "baseCurrency"=>"JPY",
           "memo"=>"hoge",
        "name"=>"aud -> jpy", 
        # "principalJPY"=>"10000", 
        "principalForeign"=>"800", 
        # "duration"=>"", 
        "exchangeRate"=>"93", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"11", 
        "date(3i)"=>"3", 
        # "interestRate"=>"", 
        # "valueForeign"=>"930", 
        "valueJPY"=>"80000",
        "baseCurrency"=>"JPY"}
    end
    
    
    account = 
      Account.find(:first, :conditions => {:currency => "AUD"})
    # p account

    assert_equal -800, account.balance
    assert_equal 1, account.account_trans.count
    
    

    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

end
