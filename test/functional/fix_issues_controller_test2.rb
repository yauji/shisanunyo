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

  test "should destroy fix_issue jpy teiki" do
    assert_difference('BaseIssue.count', -1) do
      delete :destroy, :id => base_issues(:teiki_jpy01)
    end

    assert_redirected_to fix_issues_path
  end
=begin
=end

  test "should destroy fix_issue aud teiki active" do

    @target_fi = base_issues(:teiki_aud01)

    @ats = AccountTran.where(date: @target_fi.date).where(expenditure: @target_fi.principalForeign)
#    @ats = AccountTran.find(:all)

#    p ">>>"
#    p @ats

    assert_equal(1, @ats.count)

    account = @ats.first.account
#    assert_equal(12, account.balance)

    assert_difference('BaseIssue.count', -1) do
      delete :destroy, :id => base_issues(:teiki_aud01)
    end

    @ats = AccountTran.where(date: @target_fi.date).where(expenditure: @target_fi.principalForeign)

    assert_equal(0, @ats.count)

    #check balance
    ats2 = AccountTran.where(account_id: account.id)

    balance = 0
    ats2.each do |at|
      if !at.income.nil? then
        balance += at.income
      end
      if !at.expenditure.nil? then
        balance -= at.expenditure
      end
    end
    
    accountAfter = Account.where(id: account.id)
#    p "after>>"
#    p balance
#    p accountAfter.first.balance
#    assert_equal(-310, accountAfter.balance)
    assert_equal(balance, accountAfter.first.balance)
    

    assert_redirected_to fix_issues_path
  end

  test "should destroy fix_issue jpy teiki finished" do
    target_fi = base_issues(:teiki_jpy01_finished)

    assert_difference('BaseIssue.count', -1) do
      delete :destroy, :id => target_fi
    end

    assert_redirected_to fix_issues_path
  end




  test "should destroy fix_issue jpy->aud finished" do
    target_fi = base_issues(:shikumi_jpyaud02_finished)

    ats = AccountTran.where(date: target_fi.endDate).where(income: target_fi.valueForeign)
    account = ats.first.account

    assert_difference('BaseIssue.count', -1) do
      assert_difference('AccountTran.count', -1) do
        delete :destroy, :id => target_fi
      end
    end


    #check balance
    ats2 = AccountTran.where(account_id: account.id)

    balance = 0
    ats2.each do |at|
      if !at.income.nil? then
        balance += at.income
      end
      if !at.expenditure.nil? then
        balance -= at.expenditure
      end
    end
    
    accountAfter = Account.where(id: account.id)
    assert_equal(balance, accountAfter.first.balance)

    assert_redirected_to fix_issues_path
  end


  test "should destroy fix_issue aud->usd finished" do
    target_fi = base_issues(:shikumi_audusd01_finished)

#    ats = AccountTran.where(date: target_fi.endDate).where(income: target_fi.valueForeign)
#    account = ats.first.account

    assert_difference('BaseIssue.count', -1) do
      assert_difference('AccountTran.count', -2) do
        delete :destroy, :id => target_fi
      end
    end

    accountPri = Account.where(currency: target_fi.principalCurrency)
    accountBase = Account.where(currency: target_fi.baseCurrency)
                                    
#    p accountPri
#    p accountBase


=begin
    #check balance
    ats2 = AccountTran.where(account_id: account.id)

    balance = 0
    ats2.each do |at|
      if !at.income.nil? then
        balance += at.income
      end
      if !at.expenditure.nil? then
        balance -= at.expenditure
      end
    end
    
    accountAfter = Account.where(id: account.id)
    assert_equal(balance, accountAfter.first.balance)
=end

    assert_redirected_to fix_issues_path
  end


end
