class RequestController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @reqs = Request.all
  end
  
  def new
    #check whether they have any circles. If not we need to redirect
    if current_user.circle.empty?
      flash[:notice] = "You need to create a circle before you can request baby sitting"
      redirect_to new_circle_url
    else
      @request = Request.new;
      @request.user_id = current_user.id;
      @request.description = "We just want to go out"
    end
  end
  
  def create
    r = Request.new(params[:request])
    c = current_user.circle.first
    r.circle << c
    current_user.request << r
    
    if current_user.save && r.save
      flash[:notice] = "Request for baby sitting successfully created"
      redirect_to request_index_path
    else
      redirect_to :action => "new"
    end
  end
  
end
