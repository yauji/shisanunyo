require 'base_issue'

class FixIssuesController < ApplicationController
  # GET /fix_issues
  # GET /fix_issues.json
  def index
    @fix_issues = FixIssue.find(:all, :order => "date ASC")
#    @fix_issues = FixIssue.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @fix_issues }
    end
  end

  # GET /fix_issues/1
  # GET /fix_issues/1.json
  def show
    @fix_issue = FixIssue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @fix_issue }
    end
  end

  # GET /fix_issues/new
  # GET /fix_issues/new.json
  def new
    @fix_issue = FixIssue.new
    

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @fix_issue }
    end
  end

  # GET /fix_issues/1/edit
  def edit
    @fix_issue = FixIssue.find(params[:id])
  end

  # GET /fix_issues/1/edit_end
  def edit_end
    @fix_issue = FixIssue.find(params[:id])
    
    if @fix_issue.status == IssueStatus::FINISHED then
        flash[:error] = "You can select only active issues."
        redirect_to fix_issues_path
        return
    end
    
  end

  # POST /fix_issues
  # POST /fix_issues.json
  def create
    requestType = params[:fi_requestType]

    @fix_issue = FixIssue.new(params[:fix_issue])
    
    if requestType == "jpy2fc" then
      @fix_issue.status = IssueStatus::FINISHED
      
      #update account ----
      account = 
        Account.find(:first, :conditions => {:currency => @fix_issue.baseCurrency})

      #check input---
      isError = false        
        flash[:error] = ""
      if account.nil? then
        flash[:error] = "There is no account with " + @fix_issue.baseCurrency + ". "
        isError = true
      end
      if @fix_issue.principalJPY.nil? then
        flash[:error] += "Principal JPY is mandatory. "
        isError = true
      end
      if @fix_issue.valueForeign.nil? then
        flash[:error] += "valueForeign JPY is mandatory. "
        isError = true
      end
      
      if isError then
        redirect_to new_fix_issue_path
        return
      end


      #if balance is zero
      if account.balance.nil? then
        balance = @fix_issue.valueForeign
      else
        balance = account.balance + @fix_issue.valueForeign
      end
      
      account.update_attribute  :balance , balance
      
      #add account trans ----
      accountTran = AccountTran.new(
        :date => @fix_issue.date,
        :income => @fix_issue.valueForeign)
      accountTran.account = account
      accountTran.save

      
    elsif requestType == "fc2jpy" then
      @fix_issue.status = IssueStatus::FINISHED
      
      #update account ----
      account = 
        Account.find(:first, :conditions => {:currency => @fix_issue.principalCurrency})
        
      #check input---
      isError = false        
        flash[:error] = ""
      if account.nil? then
        flash[:error] = "There is no account with " + @fix_issue.principalCurrency + ". "
        isError = true
      end
      if @fix_issue.principalForeign.nil? then
        flash[:error] += "Principal Foreign is mandatory. "
        isError = true
      end
      if @fix_issue.valueJPY.nil? then
        flash[:error] += "valueJPY is mandatory. "
        isError = true
      end
      
      if isError then
        redirect_to new_fix_issue_path
        return
      end

      updateAccountBalanceAndAddTran4ExpenditureFC account
            
      
    elsif requestType == "teiki_jpy" then
      @fix_issue.status = IssueStatus::ACTIVE
      
      #check input---
      isError = false        
      if @fix_issue.principalJPY.nil? then
        flash[:error] += "Principal JPY is mandatory. "
        isError = true
      end
      if @fix_issue.interestRate.nil? then
        flash[:error] += "interest rate is mandatory. "
        isError = true
      end
      if @fix_issue.duration.nil? then
        flash[:error] += "duration is mandatory. "
        isError = true
      end
      
      if isError then
        redirect_to new_fix_issue_path
        return
      end
      
    elsif requestType == "teiki_fc" then
      @fix_issue.status = IssueStatus::ACTIVE
      
      #update account ----
      account = 
        Account.find(:first, :conditions => {:currency => @fix_issue.principalCurrency})
        
      #check input---
      isError = false        
        flash[:error] = ""
      if account.nil? then
        flash[:error] = "There is no account with " + @fix_issue.principalCurrency + ". "
        isError = true
      end
      if @fix_issue.principalForeign.nil? then
        flash[:error] += "Principal Foreign is mandatory. "
        isError = true
      end
      if @fix_issue.interestRate.nil? then
        flash[:error] += "interest rate is mandatory. "
        isError = true
      end
      if @fix_issue.duration.nil? then
        flash[:error] += "duration is mandatory. "
        isError = true
      end
      
      if isError then
        redirect_to new_fix_issue_path
        return
      end

      updateAccountBalanceAndAddTran4ExpenditureFC account

    elsif requestType == "shikumi_jpy2fc" then
      @fix_issue.status = IssueStatus::ACTIVE
      
      #check input---
      isError = false        
      if @fix_issue.principalJPY.nil? then
        flash[:error] += "Principal JPY is mandatory. "
        isError = true
      end
      
      if isError then
        redirect_to new_fix_issue_path
        return
      end
      
    elsif requestType == "shikumi_fc2jpy" then
      updateAccount 
      
    elsif requestType == "shikumi_fc2fc" then
      updateAccount 

    end
    
    

    respond_to do |format|
      if @fix_issue.save
        format.html { redirect_to @fix_issue, :notice => 'Base issue was successfully created.' }
        format.json { render :json => @fix_issue, :status => :created, :location => @fix_issue }
      else
        format.html { render :action => "new" }
        format.json { render :json => @fix_issue.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def updateAccountBalanceAndAddTran4ExpenditureFC account
      balance = account.balance - @fix_issue.principalForeign
      account.update_attribute  :balance , balance
      
      #add account trans ----
      accountTran = AccountTran.new(
        :date => @fix_issue.date,
        :expenditure => @fix_issue.principalForeign)
      accountTran.account = account
      accountTran.save
  end
  
  def updateAccount 
      @fix_issue.status = IssueStatus::ACTIVE
      
      # p "----------------"
      # p @fix_issue
      
      #update account ----
      account = 
        Account.find(:first, :conditions => {:currency => @fix_issue.principalCurrency})
        
      #check input---
      #check input---
      isError = false
      flash[:error] = ""
      if account.nil? then
        flash[:error] = "There is no account with " + @fix_issue.principalCurrency + ". "
        isError = true
      end
      if @fix_issue.principalForeign.nil? then
        flash[:error] += "Principal Foreign is mandatory. "
        isError = true
      end
      
      if isError then
        redirect_to new_fix_issue_path
        return
      end


      balance = account.balance - @fix_issue.principalForeign
      account.update_attribute :balance , balance
      
      #add account trans ----
      accountTran = AccountTran.new(
        :date => @fix_issue.date,
        :expenditure => @fix_issue.principalForeign)
      accountTran.account = account
      accountTran.save
    
  end

  # PUT /fix_issues/1
  # PUT /fix_issues/1.json
  def update
    @fix_issue = FixIssue.find(params[:id])

    if params[:type] == "edit_end" then
      params[:fix_issue][:status] = IssueStatus::FINISHED
      
      # if users change baseCurrency when edit_end
      unless params[:fix_issue][:baseCurrency].nil? then
        @fix_issue.baseCurrency = params[:fix_issue][:baseCurrency]
      end
      
      if @fix_issue.baseCurrency != Currency::JPY then
        #update account ----

        account =
        Account.find(:first, :conditions => {:currency => @fix_issue.baseCurrency})

        #check input---
        isError = false
        flash[:error] = ""
        if account.nil? then
          flash[:error] = "There is no account with " + @fix_issue.baseCurrency + ". "
        isError = true
        end
        if params[:fix_issue][:valueForeign].nil? then
          flash[:error] += "value Foreign is mandatory. "
        isError = true
        end
        

        if isError then
          redirect_to edit_end_fix_issue_path
          return
        end

        balance = account.balance + params[:fix_issue][:valueForeign].to_f
        account.update_attribute :balance , balance

        #add account trans ----
        accountTran = AccountTran.new(
          :date => params[:fix_issue][:endDate],
          :income => params[:fix_issue][:valueForeign])
        accountTran.account = account
        accountTran.save
        
      end
      
    end

    respond_to do |format|
      if @fix_issue.update_attributes(params[:fix_issue])
        format.html { redirect_to @fix_issue, :notice => 'Base issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @fix_issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fix_issues/1
  # DELETE /fix_issues/1.json
  def destroy
#    p ">>>>>>>>>>>>>>>>>"
#    p params

    @fix_issue = FixIssue.find(params[:id])

#    p @fix_issue


    if @fix_issue.status == IssueStatus::ACTIVE then
      if @fix_issue.principalCurrency == 'JPY' then
        #delete fix issue
        @fix_issue.destroy
      else
#        @ats = AccountTran.find(:all, :conditions => {:date => @fix_issue.date, :expenditure => @fix_issue.principalForeign})
        @ats = AccountTran.where(date: @fix_issue.date).where(expenditure: @fix_issue.principalForeign)

        p @ats

        if @ats.count != 1 then
          #TODO throw exception?
          
        end

        @ats.first.destroy

        #TODO update balance account
          
        @fix_issue.destroy

      end
      #delete account trans
      ats = 
        AccountTran.where(:date => @fix_issue.date)

      p ats

    elsif @fix_issue.status == IssueStatus::FINISHED then
      

    end

        

#    @fix_issue.destroy

    respond_to do |format|
      format.html { redirect_to fix_issues_url }
      format.json { head :no_content }
    end
  end
end
