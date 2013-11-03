class BaseIssuesController < ApplicationController
  # GET /base_issues
  # GET /base_issues.json
  def index
    @base_issues = BaseIssue.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @base_issues }
    end
  end

  # GET /base_issues/1
  # GET /base_issues/1.json
  def show
    @base_issue = BaseIssue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @base_issue }
    end
  end

  # GET /base_issues/new
  # GET /base_issues/new.json
  def new
    @base_issue = BaseIssue.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @base_issue }
    end
  end

  # GET /base_issues/1/edit
  def edit
    @base_issue = BaseIssue.find(params[:id])
  end

  # POST /base_issues
  # POST /base_issues.json
  def create
    @base_issue = BaseIssue.new(params[:base_issue])

    respond_to do |format|
      if @base_issue.save
        format.html { redirect_to @base_issue, :notice => 'Base issue was successfully created.' }
        format.json { render :json => @base_issue, :status => :created, :location => @base_issue }
      else
        format.html { render :action => "new" }
        format.json { render :json => @base_issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /base_issues/1
  # PUT /base_issues/1.json
  def update
    @base_issue = BaseIssue.find(params[:id])

    respond_to do |format|
      if @base_issue.update_attributes(params[:base_issue])
        format.html { redirect_to @base_issue, :notice => 'Base issue was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @base_issue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /base_issues/1
  # DELETE /base_issues/1.json
  def destroy
    @base_issue = BaseIssue.find(params[:id])
    @base_issue.destroy

    respond_to do |format|
      format.html { redirect_to base_issues_url }
      format.json { head :no_content }
    end
  end
end
