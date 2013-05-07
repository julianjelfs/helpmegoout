class RequestController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @reqs = Request.joins(:circle => :user).where(:users => {:id => current_user.id })
  end

  
  def new
    #check whether they have any circles. If not we need to redirect
    if current_user.circle.empty?
      redirect_to new_circle_url, notice:"You need to create a circle before you can request baby sitting"
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
      redirect_to request_index_path, notive:"Request for baby sitting successfully created"
    else
      redirect_to :action => "new"
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to request_index_url
  end
  
end
