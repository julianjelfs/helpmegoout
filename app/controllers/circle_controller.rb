class CircleController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @circles = current_user.circle.all
  end
  
  def new
    @circle = Circle.new
    @circle.user_id = current_user.id
  end
  
  def create
    c = Circle.new(params[:circle])
    current_user.circle << c
    if current_user.save
      redirect_to new_request_path
    else
      redirect_to :action => "new"
    end
  end
  
end