require 'base_issue'

class FixIssuesController < ApplicationController
  # GET /fix_issues
  # GET /fix_issues.json
  def index
    @fix_issues = FixIssue.all
    
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
        
      if account.nil? then
        redirect_to new_fix_issue_path
        flash[:error] = "There is no account with " + @fix_issue.baseCurrency
        return      
      end
            
      balance = account.balance + @fix_issue.valueForeign
      account.update_attribute  :balance , balance
      
      #add account trans ----
      accountTran = AccountTran.new(
        :date => @fix_issue.date,
        :income => @fix_issue.valueForeign)
      accountTran.account = account
      accountTran.save

      
    elsif requestType == "fc2jpy" then
    elsif requestType == "teiki_jpy" then
    elsif requestType == "teiki_fc" then
    elsif requestType == "shikumi_jpy2fc" then
    elsif requestType == "shikumi_fc2jpy" then
    elsif requestType == "shikumi_fc2fc" then
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

  # PUT /fix_issues/1
  # PUT /fix_issues/1.json
  def update
    @fix_issue = FixIssue.find(params[:id])

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
    @fix_issue = FixIssue.find(params[:id])
    @fix_issue.destroy

    respond_to do |format|
      format.html { redirect_to fix_issues_url }
      format.json { head :no_content }
    end
  end
end
