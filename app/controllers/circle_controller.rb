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
    current_users = @circle.user.all.map {|u| u.email }

    params[:users].each do |u|
      if(!current_users.include? u)
        newuser = User.where("email = ?", u).first
        if(newuser)
          @circle.user << newuser
        else
           candidate = Candidate.where("email = ?", u).first
           if(candidate)
             @circle.candidate << candidate
           end
        end
      end
    end

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

  def friend_search()
      #find users or candidates in my circles that match the prefix
    prefix = params[:prefix]
    users = []
    User.all.each do |u|
      users << u.email
    end
    Candidate.all.each do |c|
      users << c.email
    end

    render :json => users
  end

end