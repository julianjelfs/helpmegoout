class CircleController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @circles = current_user.circle.all
  end

  def new
    @circle = Circle.new
    @circle.owner_id = current_user.id
  end
  
  def create
    c = Circle.new(params[:circle])
    if c.valid?
      current_user.circle << c
      redirect_to circle_index_url, notice: 'Circle successfully created'
    else
      redirect_to :action => 'new'
    end
  end

  def edit
    @circle = Circle.find(params[:id])
  end

  def update
    @circle = Circle.find(params[:id])
    if @circle.update_attributes(params[:circle])
      redirect_to circle_index_url, notice: 'Circle successfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @circle = Circle.find(params[:id])
    @circle.destroy
    redirect_to circle_index_url
  end


end