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
    @unfix_issue = BaseIssue.new(params[:unfix_issue])

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
    @unfix_issue = BaseIssue.find(params[:id])

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
