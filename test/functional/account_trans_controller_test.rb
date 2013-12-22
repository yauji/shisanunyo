require 'test_helper'

class AccountTransControllerTest < ActionController::TestCase
  setup do
    @account_tran = account_trans(:aud01)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:account_trans)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account_tran" do
    assert_difference('AccountTran.count') do
      post :create, :account_tran => { :date => @account_tran.date, :expenditure => @account_tran.expenditure, :income => @account_tran.income, :memo => @account_tran.memo }
    end

    assert_redirected_to account_tran_path(assigns(:account_tran))
  end

  test "should show account_tran" do
    get :show, :id => @account_tran
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @account_tran
    assert_response :success
  end

  test "should update account_tran" do
    put :update, :id => @account_tran, :account_tran => { :date => @account_tran.date, :expenditure => @account_tran.expenditure, :income => @account_tran.income, :memo => @account_tran.memo }
    assert_redirected_to account_tran_path(assigns(:account_tran))
  end

  test "should destroy account_tran" do
    assert_difference('AccountTran.count', -1) do
      delete :destroy, :id => @account_tran
    end

    assert_redirected_to account_trans_path
  end
end
