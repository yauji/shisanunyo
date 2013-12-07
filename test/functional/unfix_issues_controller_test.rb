require 'test_helper'

class UnfixIssuesControllerTest < ActionController::TestCase
  test "should create shintaku jpy" do
    
=begin
    uis = UnfixIssue.all
    for ui in uis do
      p ui
      p ui.tradeLogs
    end
=end
    assert_difference('UnfixIssue.count') do
      post :create, "ui_requestType"=>"jpy", 
        "tradelogDate" => "11/23",
        "tradelogBasePrice" => "100",
        "tradelogNoItem" => "100",
        "unfix_issue"=>{
           "name"=>"toushin", 
           "principalJPY"=>"10000", 
           "memo"=>"hogehoge",
         }
               
    end

    ui = UnfixIssue.find(:first, 
      :conditions => ['name = ?', 'toushin'])

    assert_equal 10000, ui.principalJPY
    
    assert_equal 10000, ui.tradeLogs.first.buyValueJPY

    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end
  
end
