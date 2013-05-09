class RegistrationsController < Devise::RegistrationsController

  def new
    super
  end

  def create
    @user = params[:user]
    circles = []
    candidate = Candidate.where(:email => @user[:email]).first

    ActiveRecord::Base.transaction do
      #remove the candidate from any circles that they were added to
      if(candidate)
        Circle.joins(:candidate).where(:candidates => {:id => candidate.id}).each do |c|
          circles << c
          c.candidate.delete(candidate)
        end
        candidate.destroy
      end

      #register the user
      super

      #add the newly created user to the circles that they belonged to as a candidate
      if(current_user)
        circles.each do |c|
          c.user << current_user
        end
      end
    end

  end

  def update
    super
  end

  def edit
    super
  end

end