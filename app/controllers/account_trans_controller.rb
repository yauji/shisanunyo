class AccountTransController < ApplicationController
  # GET /account_trans
  # GET /account_trans.json
  def index
    @account_trans = AccountTran.order(:date)
    #@account_trans = AccountTran.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @account_trans }
    end
  end

  # GET /account_trans/1
  # GET /account_trans/1.json
  def show
    @account_tran = AccountTran.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @account_tran }
    end
  end

  # GET /account_trans/new
  # GET /account_trans/new.json
  def new
    @account_tran = AccountTran.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @account_tran }
    end
  end

  # GET /account_trans/1/edit
  def edit
    @account_tran = AccountTran.find(params[:id])
  end

  # POST /account_trans
  # POST /account_trans.json
  def create
    @account_tran = AccountTran.new(params[:account_tran])

    respond_to do |format|
      if @account_tran.save
        format.html { redirect_to @account_tran, :notice => 'Account tran was successfully created.' }
        format.json { render :json => @account_tran, :status => :created, :location => @account_tran }
      else
        format.html { render :action => "new" }
        format.json { render :json => @account_tran.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /account_trans/1
  # PUT /account_trans/1.json
  def update
    @account_tran = AccountTran.find(params[:id])

    respond_to do |format|
      if @account_tran.update_attributes(params[:account_tran])
        format.html { redirect_to @account_tran, :notice => 'Account tran was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @account_tran.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /account_trans/1
  # DELETE /account_trans/1.json
  def destroy
    @account_tran = AccountTran.find(params[:id])
    @account_tran.destroy

    respond_to do |format|
      format.html { redirect_to account_trans_url }
      format.json { head :no_content }
    end
  end
end
