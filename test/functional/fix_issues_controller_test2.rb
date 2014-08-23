# -*- coding: utf-8 -*-
require 'test_helper'
# require 'application_controller'

class FixIssuesControllerTest < ActionController::TestCase
  setup do
#    @base_issue = base_issues(:one)

    user = 'yoji'
    pw = 'oza'
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user,pw)
    
  end

=begin
  test "should destroy fix_issue jpy teiki" do
    assert_difference('BaseIssue.count', -1) do
      delete :destroy, :id => base_issues(:teiki_jpy01)
    end

    assert_redirected_to fix_issues_path
  end
=end

  test "should destroy fix_issue aud teiki active" do

    @target_fi = base_issues(:teiki_aud01)

    @ats = AccountTran.where(date: @target_fi.date).where(expenditure: @target_fi.principalForeign)
#    @ats = AccountTran.find(:all)

#    p ">>>"
#    p @ats

    assert_equal(1, @ats.count)


    assert_difference('BaseIssue.count', -1) do
      delete :destroy, :id => base_issues(:teiki_aud01)
    end

    @ats = AccountTran.where(date: @target_fi.date).where(expenditure: @target_fi.principalForeign)

    assert_equal(0, @ats.count)
    
    

    assert_redirected_to fix_issues_path
  end


end
