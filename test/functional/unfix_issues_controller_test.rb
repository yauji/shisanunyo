require 'test_helper'

class UnfixIssuesControllerTest < ActionController::TestCase
  setup do
    user = 'yoji'
    pw = 'oza'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)


    @unfix_issue_n225 = base_issues(:toushi_shintaku_n225)
  end

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
        "tradelogBasePrice" => "120",
        "tradelogNoItem" => "100",
        "unfix_issue"=>{
           "name"=>"toushin", 
           "principalJPY"=>"12000", 
           "memo"=>"hogehoge",
         }
    end

    ui = UnfixIssue.find(:first, 
      :conditions => ['name = ?', 'toushin'])

    assert_equal 12000, ui.principalJPY
    
    assert_equal 12000, ui.tradeLogs.first.buyValueJPY
    
    assert_equal 100, ui.noItem

    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

  # not necessary?  
  test "should update unfix_issue n225" do
    
    ui_name = "toushin_modi"
    
    put :update, :id => @unfix_issue_n225,
      "ui_requestType"=>"jpy", 
      "tradelogDate" => "11/25",
      "tradelogBasePrice" => "123",
      "tradelogNoItem" => "100",
      "unfix_issue"=>{
         "name"=>ui_name, 
         "principalJPY"=>"10000", 
         "memo"=>"hogehoge_modi",
       } 
    assert_redirected_to unfix_issue_path(assigns(:unfix_issue))
    
    ui = UnfixIssue.find(@unfix_issue_n225)

    assert_equal ui_name, ui.name
    
  end

  test "should create unfix_issue fc" do
    
    assert_difference('UnfixIssue.count') do
      post :create, "ui_requestType"=>"fc", 
        "tradelogDate" => "2/3",
        "tradelogBasePriceForeign" => "100",
        "tradelogNoItem" => "2",
        "unfix_issue"=>{
           "principalCurrency"=>"AUD", 
           "principalForeign"=>"200", 
           "baseCurrency"=>"AUD", 
           "name"=>"toushin fc", 
           "memo"=>"hogehoge",
         }
    end

    ui = UnfixIssue.find(:first, 
      :conditions => ['name = ?', 'toushin fc'])

    assert_equal 200, ui.principalForeign
    
    assert_equal 200, ui.tradeLogs.first.buyValueForeign
    
    assert_equal 2, ui.noItem
    
  end

=begin  
  test "should update unfix_issue n225 (buy)" do
    
    ui_name = "toushin_modi"
    
    # p "----------------"
    # p @unfix_issue_n225.id
    
    put :create,
      :commit=>"Create trade log",
      :ui_baseCurrency=>"jpy",
      "ui_id" => @unfix_issue_n225.id,
      "tradelog" => {
        "basicPrice"=>"11",
        "buyValueJPY"=>"110",
        "tradeType"=>"buy",
        "date"=>"1/3",
        "noItem" =>"10" 
      }

    assert_redirected_to unfix_issue_path(assigns(:unfix_issue))
    
    ui = UnfixIssue.find(@unfix_issue_n225)

    assert_equal 5110, ui.principalJPY
    assert_equal 20, ui.noItem
    
    
    assert_equal 3, ui.tradeLogs.length
    
    

    assert_equal ui_name, ui.name
    
  end
=end
  
  

  

  
end
