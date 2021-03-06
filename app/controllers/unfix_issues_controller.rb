class UnfixIssuesController < ApplicationController
  # GET /unfix_issues
  # GET /unfix_issues.json
  def index
    @unfix_issues = UnfixIssue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @unfix_issues }
    end
  end

  # GET /unfix_issues/1
  # GET /unfix_issues/1.json
  def show
    @unfix_issue = BaseIssue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @unfix_issue }
    end
  end

  # GET /unfix_issues/new
  # GET /unfix_issues/new.json
  def new
    @unfix_issue = UnfixIssue.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @unfix_issue }
    end
  end

  # GET /unfix_issues/1/edit
  def edit
    @unfix_issue = BaseIssue.find(params[:id])
  end

  # POST /unfix_issues
  # POST /unfix_issues.json
  def create
    #TODO delete
    # p "=-----------------"
    # p params
    
    @unfix_issue = UnfixIssue.new(params[:unfix_issue])
    
    requestType = params[:ui_requestType]

  #check input---
    isError = false
 # flash[:error] = ""
    @errors = []
    if params[:tradelogDate] == "" then
      @errors.push "date is mandatory. "
    # flash[:error] += "date is mandatory. "
    isError = true
    end
    if params[:tradelogNoItem] == "" then
      @errors.push "no item is mandatory. "
    isError = true
    end

    if requestType == "jpy" then
      if params[:tradelogBasicPrice] == "" then
        @errors.push "basic price is mandatory. "
     isError = true
     end
      if @unfix_issue.principalJPY.nil? then
        @errors.push  "Principal JPY is mandatory. "
        isError = true
      end
      
      if isError then
        respond_to do |format|
          format.html { render :action => "new" }
        end
        return
      end

      @unfix_issue.noItem = params[:tradelogNoItem]
      @unfix_issue.principalCurrency = Currency::JPY 
      @unfix_issue.baseCurrency = Currency::JPY 
      @unfix_issue.status = IssueStatus::ACTIVE
      
      tradeLog = TradeLog.new(
        # :date => params[:tradelogDate],
        :tradeType => TradeType::BUY, 
        :basicPrice => params[:tradelogBasicPrice],
        :noItem => params[:tradelogNoItem],
        :buyValueJPY => @unfix_issue.principalJPY
      )
      
      tradeLog.date = Date.parse(params[:tradelogDate])

      tradeLog.save

      @unfix_issue.tradeLogs << tradeLog
    else
      #if foreign currency
      if params[:tradelogBasicPriceForeign] == "" then
        @errors.push "basic price foreign is mandatory. "
      isError = true
      end
      if @unfix_issue.principalForeign.nil? then
        @errors.push  "Principal Foreign is mandatory. "
        isError = true
      end
      
      if isError then
        respond_to do |format|
          format.html { render :action => "new" }
        end
        return
      end

      @unfix_issue.noItem = params[:tradelogNoItem]
      @unfix_issue.principalCurrency = @unfix_issue.principalCurrency 
      @unfix_issue.baseCurrency = @unfix_issue.baseCurrency
      @unfix_issue.status = IssueStatus::ACTIVE

      tradeLog = TradeLog.new(
        :tradeType => TradeType::BUY, 
        :basicPriceForeign => params[:tradelogBasicPriceForeign],
        :noItem => params[:tradelogNoItem],
        :buyValueForeign => @unfix_issue.principalForeign
      )
      
      tradeLog.date = Date.parse(params[:tradelogDate])

      tradeLog.save

      @unfix_issue.tradeLogs << tradeLog
          
    end
    
   # p @unfix_issue

    respond_to do |format|
      if @unfix_issue.save
        format.html { redirect_to @unfix_issue, :notice => 'Base issue was successfully created.' }
        format.json { render :json => @unfix_issue, :status => :created, :location => @unfix_issue }
      else
        format.html { render :action => "new" }
        format.json { render :json => @unfix_issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /unfix_issues/1
  # PUT /unfix_issues/1.json
  def update
    @unfix_issue = UnfixIssue.find(params[:id])
    # @unfix_issue = BaseIssue.find(params[:id])

    respond_to do |format|
      if @unfix_issue.update_attributes(params[:unfix_issue])
        format.html { redirect_to @unfix_issue, :notice => 'Base issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @unfix_issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /unfix_issues/1
  # DELETE /unfix_issues/1.json
  def destroy
    @unfix_issue = BaseIssue.find(params[:id])
    @unfix_issue.destroy

    respond_to do |format|
      format.html { redirect_to unfix_issues_url }
      format.json { head :no_content }
    end
  end
end
