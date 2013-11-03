require 'test_helper'

class FixIssuesControllerTest < ActionController::TestCase
  setup do
    @base_issue = base_issues(:one)
  end
  
  test "should create base_issue" do
    assert_difference('BaseIssue.count') do
      post :create, :base_issue => { :baseCurrency => @base_issue.baseCurrency, :date => @base_issue.date, :duration => @base_issue.duration, :endDate => @base_issue.endDate, :exchangeRate => @base_issue.exchangeRate, :interestRate => @base_issue.interestRate, :name => @base_issue.name, :noItem => @base_issue.noItem, :principalForeign => @base_issue.principalForeign, :principalJPY => @base_issue.principalJPY, :status => @base_issue.status, :valueForeign => @base_issue.valueForeign, :valueJPY => @base_issue.valueJPY }
    end

    assert_redirected_to base_issue_path(assigns(:base_issue))
  end

end
