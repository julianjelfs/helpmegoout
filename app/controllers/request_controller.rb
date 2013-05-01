class RequestController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @reqs = Request.where("user_id != ?", current_user.id)
  end
  
  def new
    @request = Request.new;
    @request.user_id = current_user.id;
    @request.description = "We just want to go out"
  end
end
