require 'test_helper'

class BaseIssuesControllerTest < ActionController::TestCase
  setup do
    @base_issue = base_issues(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:base_issues)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create base_issue" do
    assert_difference('BaseIssue.count') do
      post :create, :base_issue => { :baseCurrency => @base_issue.baseCurrency, :date => @base_issue.date, :duration => @base_issue.duration, :endDate => @base_issue.endDate, :exchangeRate => @base_issue.exchangeRate, :interestRate => @base_issue.interestRate, :name => @base_issue.name, :noItem => @base_issue.noItem, :principalForeign => @base_issue.principalForeign, :principalJPY => @base_issue.principalJPY, :status => @base_issue.status, :valueForeign => @base_issue.valueForeign, :valueJPY => @base_issue.valueJPY }
    end

    assert_redirected_to base_issue_path(assigns(:base_issue))
  end

  test "should show base_issue" do
    get :show, :id => @base_issue
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @base_issue
    assert_response :success
  end

  test "should update base_issue" do
    put :update, :id => @base_issue, :base_issue => { :baseCurrency => @base_issue.baseCurrency, :date => @base_issue.date, :duration => @base_issue.duration, :endDate => @base_issue.endDate, :exchangeRate => @base_issue.exchangeRate, :interestRate => @base_issue.interestRate, :name => @base_issue.name, :noItem => @base_issue.noItem, :principalForeign => @base_issue.principalForeign, :principalJPY => @base_issue.principalJPY, :status => @base_issue.status, :valueForeign => @base_issue.valueForeign, :valueJPY => @base_issue.valueJPY }
    assert_redirected_to base_issue_path(assigns(:base_issue))
  end

  test "should destroy base_issue" do
    assert_difference('BaseIssue.count', -1) do
      delete :destroy, :id => @base_issue
    end

    assert_redirected_to base_issues_path
  end
end
