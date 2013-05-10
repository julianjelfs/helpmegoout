class RequestController < ApplicationController
  
  before_filter :authenticate_user!

  def accept
    @request = Request.find(params[:id]);
    if(@request)
      @request.volunteer = current_user
      @request.save
    end
    render json: @request
    end

  def reject
    @request = Request.find(params[:id]);
    if(@request)
      @request.volunteer = nil
      @request.save
    end
    render json: @request
  end

  def index
    @reqs = Request.includes(:volunteer).joins(:circle => :user).where("requests.date >= ? and circles_users.user_id = ?", Time.now, current_user.id).order("date")
    if(!@reqs)
      @reqs = []
    end
  end

  
  def new
    @title = "When would you like to go out?"
    #check whether they have any circles. If not we need to redirect
    if current_user.circle.empty?
      redirect_to new_circle_url, notice:"You need to create a circle before you can request baby sitting"
    else
      @request = Request.new;
      #by default we will share with all circles
      @request.circle << current_user.circle.all
      @request.user_id = current_user.id;
      @request.description = "We just want to go out"
    end
    @readonly = false
  end
  
  def create
    @request = Request.new(params[:request])

    process_circles

    current_user.request << @request
    
    if current_user.save && @request.save
      RequestMailer.delay.new_request_email(@request)
      redirect_to request_index_path, notive:"Request successfully created"
    else
      redirect_to :action => "new"
    end
  end

  def process_circles
    current_circles = @request.circle.all.map {|c| c.name}
    to_remove = []

    params[:circles].each do |c|
      if(!current_circles.include? c)
        new_circle = Circle.where("name = ?", c).first
        if(new_circle)
          @request.circle << new_circle
        end
      end
    end

    current_circles.each do |c|
      if(!params[:circles].include? c)
        new_circle = Circle.where("email = ?", c).first
        if(new_circle)
          @request.circle.delete(new_circle)
        end
      end
    end
  end

  def update
    @request = Request.find(params[:id])

    process_circles

    if @request.update_attributes(params[:request])
      redirect_to request_index_url, notice: 'Request successfully updated'
    else
      render action: 'edit'
    end
  end

  def edit
    @request = Request.find(params[:id])
    @readonly = @request.user.id != current_user.id
    @title = @readonly ? (@request.volunteer ? "#{@request.volunteer.email} has agreed to baby sit" : "Can you baby sit?") : "Do you need to update this request?"
    @show_accept = !@request.volunteer && @readonly
    @show_reject = !@request.volunteer && @readonly

  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy
    redirect_to request_index_url
  end
  
end
