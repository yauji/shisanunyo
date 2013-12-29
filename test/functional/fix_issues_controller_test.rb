# -*- coding: utf-8 -*-
require 'test_helper'
# require 'application_controller'

class FixIssuesControllerTest < ActionController::TestCase
  setup do
#    @base_issue = base_issues(:one)

    
  end
  
  test "should create fix_issue of JPY->Foreign Currency" do
    # fis = FixIssue.find(:all)
    # p fis
    
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"jpy2fc", 
        "fix_issue"=>{
           "principalCurrency"=>"JPY",
           "baseCurrency"=>"AUD",
           "memo"=>"hoge", 
        "name"=>"AUD", 
        "principalJPY"=>"10000", 
        # "principalForeign"=>"", 
        # "duration"=>"", 
        "exchangeRate"=>"93", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"11", 
        "date(3i)"=>"3", 
        # "interestRate"=>"", 
        "valueForeign"=>"930", 
        "valueJPY"=>"",
         }
    end
    
    account = 
      Account.find(:first, :conditions => {:currency => "AUD"})
    assert_equal 942, account.balance
    
    assert_equal 2, account.account_trans.count
    
    # p account
=begin   
    accountTrans =
      AccountTran.find(:all)
      
    # p account.account_trans
    # p accountTrans
      
       
    ufi = UnfixIssue.new
    ufi.save
    # p ufi
    
    # p ufi
    tl = TradeLog.new
    tl.unfixIssue = ufi
    # tl.baseIssue = ufi
    tl.save
    
    # ufi.save
    
    # p tl
    # p ufi
    
    p ufi.tradeLogs
    
    ufis = UnfixIssue.find(:all)  
    # p ufis 
    
    # p ufi
    # p ufi.tradeLogs
    
    tls = TradeLog.find(:all)
    # p tls
    
    p "------------------"
    ac = Account.new
    ac.save
    
    p ac
    
    act = AccountTran.new
    act.account = ac
    act.save
    
    p act
=end  
         
    # 
      # post :create, :base_issue => { :baseCurrency => @base_issue.baseCurrency, :date => @base_issue.date, :duration => @base_issue.duration, :endDate => @base_issue.endDate, :exchangeRate => @base_issue.exchangeRate, :interestRate => @base_issue.interestRate, :name => @base_issue.name, :noItem => @base_issue.noItem, :principalForeign => @base_issue.principalForeign, :principalJPY => @base_issue.principalJPY, :status => @base_issue.status, :valueForeign => @base_issue.valueForeign, :valueJPY => @base_issue.valueJPY }
    # end



    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

  test "should create fix_issue of Foreign Currency -> JPY" do
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"fc2jpy", 
        "fix_issue"=>{ 
           "principalCurrency"=>"AUD",
           "baseCurrency"=>"JPY",
           "memo"=>"hoge",
        "name"=>"aud -> jpy", 
        # "principalJPY"=>"10000", 
        "principalForeign"=>"800", 
        # "duration"=>"", 
        "exchangeRate"=>"93", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"11", 
        "date(3i)"=>"3", 
        # "interestRate"=>"", 
        # "valueForeign"=>"930", 
        "valueJPY"=>"80000",
        }
    end
    
    account = 
      Account.find(:first, :conditions => {:currency => "AUD"})
    # p account

    assert_equal -788, account.balance
    assert_equal 2, account.account_trans.count

    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

  test "should create teiki jpy" do
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"teiki_jpy", 
        "fix_issue"=>{ 
           "principalCurrency"=>"JPY",
           "baseCurrency"=>"JPY",
           "memo"=>"teiki jpy 123",
           "name"=>"teiki jpy", 
        "principalJPY"=>"11000", 
        # "principalForeign"=>"800", 
        "duration"=>"12", 
        # "exchangeRate"=>"93", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"10", 
        "date(3i)"=>"3", 
        "interestRate"=>"0.3", 
        # "valueForeign"=>"930", 
        # "valueJPY"=>"80000",
        }
    end

    fi = FixIssue.find(:first, 
      :conditions => ['memo = ?', 'teiki jpy 123'])

    # p fi
    assert_equal 11000, fi.principalJPY
    assert_equal "JPY", fi.baseCurrency

    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

  test "should end teiki jpy" do
    @fi = base_issues(:teiki_jpy01)
    
    #end issue teiki
    put :update, :id => @fi,
      :type => "edit_end", 
    :fix_issue => { 
      # :duration => @base_issue.duration, 
      :endDate => "2014-09-26", 
      # :interestRate => @base_issue.interestRate,  
      # :valueForeign => @base_issue.valueForeign, 
      :valueJPY => "10500" }
      
    fi_after = FixIssue.find(@fi.id)
    
    # p fi_after

    assert_equal "finished", fi_after.status
    assert_equal 10500, fi_after.valueJPY
    
    assert_redirected_to fix_issue_path(assigns(:fix_issue))
  end

  test "should create teiki fc" do
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"teiki_fc", 
        "fix_issue"=>{ 
           "principalCurrency"=>"AUD",
           "baseCurrency"=>"AUD",
           "memo"=>"teiki fc 123",
           "name"=>"teiki fc", 
        # "principalJPY"=>"11000", 
        "principalForeign"=>"200", 
        "duration"=>"24", 
        # "exchangeRate"=>"93", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"9", 
        "date(3i)"=>"3", 
        "interestRate"=>"0.5", 
        # "valueForeign"=>"930", 
        # "valueJPY"=>"80000",
        }
    end

    fi = FixIssue.find(:first, 
      :conditions => ['memo = ?', 'teiki fc 123'])

    # p fi
    assert_equal 200, fi.principalForeign
    
    account =
        Account.find(:first, :conditions => {:currency => "AUD"})

    assert_equal -188.0, account.balance
    assert_equal 2, account.account_trans.count


    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end
  
  
  
  test "should end teiki fc" do
    @fi = base_issues(:teiki_aud01)
    
    #end issue teiki
    put :update, :id => @fi,
      :type => "edit_end", 
    :fix_issue => { 
      # :duration => @base_issue.duration, 
      :endDate => "2013-08-31", 
      # :interestRate => @base_issue.interestRate,  
      :valueForeign => "1050", 
      # :valueJPY => "10500" 
      }
      
    fi_after = FixIssue.find(@fi.id)
    
    # p fi_after

    assert_equal "finished", fi_after.status
    assert_equal 1050, fi_after.valueForeign
    
    account =
        Account.find(:first, :conditions => {:currency => @fi.baseCurrency})

    assert_equal 1062.0, account.balance
    assert_equal 2, account.account_trans.count
    assert_equal 1050, account.account_trans.last.income
           
    assert_redirected_to fix_issue_path(assigns(:fix_issue))
  end

  

  test "should create shikumi_jpy2fc" do
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"shikumi_jpy2fc", 
        "fix_issue"=>{ 
           "principalCurrency"=>"JPY",
           # "baseCurrency"=>"USD",
           "memo"=>"shikumi jpy2fc 123",
           "name"=>"shikumi jpy2fc", 
        "principalJPY"=>"13000", 
        # "principalForeign"=>"200", 
        # "duration"=>"24", 
        "exchangeRate"=>"93", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"8", 
        "date(3i)"=>"3", 
        # "interestRate"=>"0.5", 
        # "valueForeign"=>"930", 
        # "valueJPY"=>"80000",
        }
    end

    fi = FixIssue.find(:first, 
      :conditions => ['memo = ?', 'shikumi jpy2fc 123'])

    # p fi
    assert_equal 13000, fi.principalJPY

    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end
  
  
  test "should end shikumi_jpy2fc aud return" do
    @fi = base_issues(:shikumi_jpyaud01)
    
    #end issue teiki
    put :update, :id => @fi,
      :type => "edit_end", 
    :fix_issue => { 
      # :duration => @base_issue.duration, 
      :endDate => "2013-08-31", 
      # :interestRate => @base_issue.interestRate,  
      :valueForeign => "1060", 
      # :valueJPY => "10500" 
      }
      
    fi_after = FixIssue.find(@fi.id)
    
    # p fi_after

    assert_equal "finished", fi_after.status
    assert_equal 1060, fi_after.valueForeign
    
    account =
        Account.find(:first, :conditions => {:currency => @fi.baseCurrency})

    assert_equal 1072.0, account.balance
    assert_equal 2, account.account_trans.count
    
    assert_redirected_to fix_issue_path(assigns(:fix_issue))
  end


  test "should end shikumi_jpy2fc jpy return" do
    @fi = base_issues(:shikumi_jpyaud01)
    
    #end issue teiki
    put :update, :id => @fi,
      :type => "edit_end", 
    :fix_issue => { 
      # :duration => @base_issue.duration, 
      :baseCurrency => "JPY", 
      :endDate => "2013-08-31", 
      # :interestRate => @base_issue.interestRate,  
      # :valueForeign => "1060", 
      :valueJPY => "10500" 
      }
      
    fi_after = FixIssue.find(@fi.id)
    
    # p fi_after

    assert_equal "finished", fi_after.status
    assert_equal 10500, fi_after.valueJPY
    
    
    assert_redirected_to fix_issue_path(assigns(:fix_issue))
  end

  

#    ["仕組預金（外貨→円）","shikumi_fc2jpy"],
  test "should create shikumi_fc2fc" do
    assert_difference('FixIssue.count') do
      post :create, "fi_requestType"=>"shikumi_fc2fc", 
        "fix_issue"=>{ 
           "principalCurrency"=>"AUD",
           "baseCurrency"=>"USD",
           "memo"=>"shikumi fc2fc 123",
           "name"=>"shikumi fc2fc", 
        # "principalJPY"=>"13000", 
        "principalForeign"=>"300", 
        # "duration"=>"24", 
        "exchangeRate"=>"0.9", 
        "date(1i)"=>"2013", 
        "date(2i)"=>"7", 
        "date(3i)"=>"3", 
        # "interestRate"=>"0.5", 
        # "valueForeign"=>"930", 
        # "valueJPY"=>"80000",
        }
    end

    fi = FixIssue.find(:first, 
      :conditions => ['memo = ?', 'shikumi fc2fc 123'])

    # p fi
    assert_equal 300, fi.principalForeign

    #assert_redirected_to base_issue_path(assigns(:base_issue))
  end

end
