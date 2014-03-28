class TradeLogsController < ApplicationController
  # GET /trade_logs
  # GET /trade_logs.json
  def index
    @trade_logs = TradeLog.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @trade_logs }
    end
  end

  # GET /trade_logs/1
  # GET /trade_logs/1.json
  def show
    @trade_log = TradeLog.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @trade_log }
    end
  end

  # GET /trade_logs/new
  # GET /trade_logs/new.json
  def new
    @trade_log = TradeLog.new
    
    #TODO delete
    p "--------------------tradelog new"
    p params
    
    @ui_id = params[:ui_id]
    
    if params[:ui_baseCurrency] == "JPY" then
      @ui_baseCurrency = "jpy"
    else
      @ui_baseCurrency = "fc"
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @trade_log }
    end
  end

  # GET /trade_logs/1/edit
  def edit
    @trade_log = TradeLog.find(params[:id])
  end

  # POST /trade_logs
  # POST /trade_logs.json
  def create
    #TODO delete
    p "--------------------tradelog create"
    p params
    
    #for the case of error
    @ui_id = params[:ui_id]

    @errors = []


    @trade_log = TradeLog.new(params[:trade_log])
    unless params[:trade_log][:date] == "" then
      @trade_log.date = Date.parse(params[:trade_log][:date])
    else
      @errors.push "date is mandatory. "
      respond_to do |format|
        format.html { render :action => "new" }
      end
      return
    end
    
    # uis = UnfixIssue.find_all_by_id @ui_id
    uis = UnfixIssue.find(:all)
    # p uis
    # p @ui_id
    ui = uis.first
    # p ui
    
    @trade_log.unfixIssue = ui
    
    if @trade_log.basicPrice == "" then
      @errors.push "date is mandatory. "
      respond_to do |format|
        format.html { render :action => "new" }
      end
      return
    end

    case @trade_log.tradeType
    when TradeType::BUY then
      ui.update_attribute :principalJPY, ui.principalJPY + @trade_log.buyValueJPY 
      ui.update_attribute :noItem, ui.noItem + @trade_log.noItem 
    when TradeType::SELL then
      # ui.update_attribute :principalJPY, ui.principalJPY - @trade_log.sellValueJPY 
      ui.update_attribute :noItem, ui.noItem - @trade_log.noItem 
    when TradeType::DIVIDEND then
      
    end
    
    
    
    respond_to do |format|
      if @trade_log.save
        format.html { redirect_to @trade_log, :notice => 'Trade log was successfully created.' }
        format.json { render :json => @trade_log, :status => :created, :location => @trade_log }
      else
        format.html { render :action => "new" }
        format.json { render :json => @trade_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /trade_logs/1
  # PUT /trade_logs/1.json
  def update
    @trade_log = TradeLog.find(params[:id])

    respond_to do |format|
      if @trade_log.update_attributes(params[:trade_log])
        format.html { redirect_to @trade_log, :notice => 'Trade log was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @trade_log.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /trade_logs/1
  # DELETE /trade_logs/1.json
  def destroy
    @trade_log = TradeLog.find(params[:id])
    @trade_log.destroy

    respond_to do |format|
      format.html { redirect_to trade_logs_url }
      format.json { head :no_content }
    end
  end
end
