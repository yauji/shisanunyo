require 'test_helper'

class UnfixIssuesControllerTest < ActionController::TestCase
  test "should create shintaku jpy" do
    
    uis = UnfixIssue.all
    
    for ui in uis do
      p ui
      
      p ui.tradeLogs
    end
=begin
    assert_difference('UnfixIssue.count') do
      post :create, "ui_requestType"=>"jpy", 
        "tradelogDate" => "11/23",
        "tradelogBasePrice" => "100",
        "tradelogNoItem" => "100",
        "unfix_issue"=>{
           "name"=>"nikkei225", 
           "principalJPY"=>"10000", 
           "memo"=>"hogehoge",
         }
               
    end

    ui = UnfixIssue.find(:first, 
      :conditions => ['name = ?', 'nikkei225'])

    assert_equal 10000, ui.principalJPY
    
    account =
        Account.find(:first, :conditions => {:currency => "AUD"})

    assert_equal -188.0, account.balance
    assert_equal 2, account.account_trans.count


    #assert_redirected_to base_issue_path(assigns(:base_issue))
=end
  end
  
end
