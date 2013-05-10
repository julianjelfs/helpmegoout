class CircleController < ApplicationController
  
  before_filter :authenticate_user!
  
  def index
    @circles = current_user.circle.all
  end

  def new
    @title = "Create a new circle"
    @circle = Circle.new
    @circle.user << current_user
    @circle.owner_id = current_user.id
    @readonly = false
  end
  
  def create
    @circle = Circle.new(params[:circle])
    if @circle.valid?
      current_user.circle << @circle

      process_users

      redirect_to circle_index_url, notice: 'Circle successfully created'
    else
      redirect_to :action => 'new'
    end
  end

  def edit
    @title = "Circle Details"
    @circle = Circle.find(params[:id])
    @readonly = @circle.owner_id != current_user.id
  end

  def process_users
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
            c = Candidate.new(:email => u)
            @circle.candidate << c
            UserMailer.delay.invitation_email(current_user, c)
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
  end

  def update
    @circle = Circle.find(params[:id])

    process_users

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