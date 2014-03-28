require 'test_helper'
# require 'base_issue'

class TradeLogsControllerTest < ActionController::TestCase
  setup do
    @trade_log = trade_logs(:nikkei225_01)
  end

=begin
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end
=end
  test "should create trade_log buy jpy" do

    # get unfix issue id
    uis = UnfixIssue.find_all_by_name "nikkei225"
    ui = uis.first
    
    
    assert_difference('TradeLog.count') do
      post :create, :trade_log => {
        :basicPrice => "123",
        :date => "2013/12/2", 
        :buyValueJPY => "1230",
        :noItem => "10",
        :tradeType => "buy" },
        :ui_id => ui.id

      tls = TradeLog.find(:all, 
        :include => :unfixIssue,
        :conditions => {:buyValueJPY => "1230"}
        )
      # p "----tls----"
      # p tls 
      
      assert_equal 1, tls.count, "not saved or invalid test data."
      
      # p tls.first.unfixIssue
      
      # p tls.first.unfixIssue
      assert_equal ui.principalJPY + 1230, 
        tls.first.unfixIssue.principalJPY

      assert_equal ui.noItem + 10, 
        tls.first.unfixIssue.noItem

    end

    assert_redirected_to trade_log_path(assigns(:trade_log))
  end


  test "should create trade_log sell jpy" do
    # get unfix issue id
    uis = UnfixIssue.find_all_by_name "nikkei225"
    ui = uis.first
    
    assert_difference('TradeLog.count') do
      post :create, :trade_log => {
        :basicPrice => "98",
        :date => "12/4", 
        :sellValueJPY => "980",
        :noItem => "10",
        :tradeType => "sell" },
        :ui_id => ui.id

      tls = TradeLog.find(:all, 
        :include => :unfixIssue,
        :conditions => {:sellValueJPY => "980"}
        )
      # p "----tls----"
      # p tls 
      
      assert_equal 1, tls.count, "not saved or invalid test data."
      
      # p tls.first.unfixIssue
      
      # p tls.first.unfixIssue
      assert_equal ui.principalJPY , 
        tls.first.unfixIssue.principalJPY

      assert_equal ui.noItem - 10, 
        tls.first.unfixIssue.noItem

    end

    assert_redirected_to trade_log_path(assigns(:trade_log))
  end



  test "should create trade_log dividend jpy" do
    # get unfix issue id
    uis = UnfixIssue.find_all_by_name "nikkei225"
    ui = uis.first
    
    assert_difference('TradeLog.count') do
      post :create, :trade_log => {
        :basicPrice => "234",
        :date => "12/8", 
        :dividendValueJPY => "2808",
        :tradeType => "dividend" },
        :ui_id => ui.id
        
      tls = TradeLog.find(:all, 
        :include => :unfixIssue,
        :conditions => {:dividendValueJPY => "2808"}
        )
      
      assert_equal 1, tls.count, "not saved or invalid test data."
      
    end

    assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  test "should create trade_log buy aus" do

    # get unfix issue id
    uis = UnfixIssue.find_all_by_name "FC"
    ui = uis.first
    
    
    assert_difference('TradeLog.count') do
      post :create, :trade_log => {
        :basicPriceForeign => "1000",
        :date => "2013/12/3", 
        :buyValueForeign => "5000",
        :noItem => "5",
        :tradeType => "buy" },
        :ui_id => ui.id

      tls = TradeLog.find(:all, 
        :include => :unfixIssue,
        :conditions => {:buyValueForeign => "5000"}
        )
      # p "----tls----"
      # p tls 
      
      assert_equal 1, tls.count, "not saved or invalid test data."
      
      # p tls.first.unfixIssue
      
      # p tls.first.unfixIssue
      assert_equal ui.principalForeign + 5000, 
        tls.first.unfixIssue.principalForeign

      assert_equal ui.noItem + 5, 
        tls.first.unfixIssue.noItem

    end

    assert_redirected_to trade_log_path(assigns(:trade_log))
  end


=begin
  test "should create trade_log" do
    assert_difference('TradeLog.count') do
      post :create, :trade_log => { 
        :basicPrice => @trade_log.basicPrice, :buyValueForeign => @trade_log.buyValueForeign, :buyValueJPY => @trade_log.buyValueJPY, :date => @trade_log.date, :dividendValueForeign => @trade_log.dividendValueForeign, :dividendValueJPY => @trade_log.dividendValueJPY, :noItem => @trade_log.noItem, :sellValueForeign => @trade_log.sellValueForeign, :sellValueJPY => @trade_log.sellValueJPY, :type => @trade_log.type }
    end

    assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  test "should show trade_log" do
    get :show, :id => @trade_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @trade_log
    assert_response :success
  end

  test "should update trade_log" do
    put :update, :id => @trade_log, :trade_log => { :basicPrice => @trade_log.basicPrice, :buyValueForeign => @trade_log.buyValueForeign, :buyValueJPY => @trade_log.buyValueJPY, :date => @trade_log.date, :dividendValueForeign => @trade_log.dividendValueForeign, :dividendValueJPY => @trade_log.dividendValueJPY, :noItem => @trade_log.noItem, :sellValueForeign => @trade_log.sellValueForeign, :sellValueJPY => @trade_log.sellValueJPY, :type => @trade_log.type }
    assert_redirected_to trade_log_path(assigns(:trade_log))
  end

  test "should destroy trade_log" do
    assert_difference('TradeLog.count', -1) do
      delete :destroy, :id => @trade_log
    end

    assert_redirected_to trade_logs_path
  end
=end
end
