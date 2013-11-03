class ApplicationController < ActionController::Base
  protect_from_forgery
  
  module IssueStatus
    ACTIVE = 'active'
    FINISHED = 'finished'
  end
end
