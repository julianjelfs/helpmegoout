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
    current_users = @circle.user.all.map {|u| u.email }.concat( @circle.candidate.all.map {|u| u.email } )
    to_remove = []

    params[:users].each do |u|
      if(!current_users.include? u)
        newuser = User.where("email = ?", u).first
        if(newuser)
          @circle.user << newuser
        else
           candidate = Candidate.where("email = ?", u).first
           if(candidate)
             @circle.candidate << candidate
           else
            @circle.candidate << Candidate.new(:email => u)
           end
        end
      end
    end

    current_users.each do |u|
      if(!params[:users].include? u)
        newuser = User.where("email = ?", u).first
        if(newuser)
          @circle.user.delete(newuser)
        else
          candidate =  Candidate.where("email = ?", u).first
          if(candidate)
            @circle.candidate.delete(candidate)
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

  # this is really not good enough because it returns all users to the client
  # needs to at very least restrict on prefix
  def friend_search()
    users = User.all.map {|u| u.email }.concat( Candidate.all.map {|u| u.email } )
    render :json => users
  end

end