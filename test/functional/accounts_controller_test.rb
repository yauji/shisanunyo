require 'test_helper'

class AccountsControllerTest < ActionController::TestCase
  setup do
    @account = accounts(:aud)

    user = 'yoji'
    pw = 'hoge'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)
  end

  test "should get index with the order" do
    get :index
    assert_response :success
    assert_not_nil assigns(:accounts)

    assert_equal "EUR", assigns(:accounts)[1].currency
    
  end

=begin
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post :create, :account => { :balance => @account.balance, :currency => @account.currency, :exchangeRate => @account.exchangeRate }
    end

    assert_redirected_to account_path(assigns(:account))
  end

  test "should show account" do
    get :show, :id => @account
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @account
    assert_response :success
  end

  test "should update account" do
    put :update, :id => @account, :account => { :balance => @account.balance, :currency => @account.currency, :exchangeRate => @account.exchangeRate }
    assert_redirected_to account_path(assigns(:account))
  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete :destroy, :id => @account
    end

    assert_redirected_to accounts_path
  end
=end
end
