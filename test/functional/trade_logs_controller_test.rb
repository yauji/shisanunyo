require 'test_helper'

class TradeLogsControllerTest < ActionController::TestCase
  setup do
    @trade_log = trade_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:trade_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create trade_log" do
    assert_difference('TradeLog.count') do
      post :create, :trade_log => { :basicPrice => @trade_log.basicPrice, :buyValueForeign => @trade_log.buyValueForeign, :buyValueJPY => @trade_log.buyValueJPY, :date => @trade_log.date, :dividendValueForeign => @trade_log.dividendValueForeign, :dividendValueJPY => @trade_log.dividendValueJPY, :noItem => @trade_log.noItem, :sellValueForeign => @trade_log.sellValueForeign, :sellValueJPY => @trade_log.sellValueJPY, :type => @trade_log.type }
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
end
