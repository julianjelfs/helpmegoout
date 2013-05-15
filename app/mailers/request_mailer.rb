class RequestMailer < ActionMailer::Base
  default from: "chiefbabysitter@helpmegoout.co.uk"

  def new_request_email(request)
    @request = Request.includes(:user).joins(:circle => :user).find(request.id)
    to = []
    @request.circle.each do |c|
      c.user.each do |u|
        if(u.id != @request.user.id)
          to << u.email
        end
      end
    end

    @url = "http://www.helpmegoout.co.uk/request/#{request.id}/edit"
    mail(:to => to, :subject => "Your friend #{@request.user.email} needs a baby sitter. Can you help?")
  end

  #if we cancel a request we just need to notify the volunteer if there is one
  def delete_request_email(request, volunteer_email, user_email)
    @request = request
    mail(:to => volunteer_email, :subject => "Your friend #{user_email} no longer needs a baby sitter")
  end
  
  def babysitting_reminder(request)
    @request = request
    @url = "http://www.helpmegoout.co.uk/request/#{request.id}/edit"
    mail(:to => request.volunteer.email, :subject => "Don't forget that you're baby sitting for #{request.user.email} today")
  end

  #if someone accepts the request email the request owner and let them know
  def accept_request_email(request)
    @url = "http://www.helpmegoout.co.uk/request/#{request.id}/edit"
    @request = Request.includes(:user).includes(:volunteer).find(request.id)
    mail(:to => @request.user.email, :subject => "Your friend #{@request.volunteer.email} has volunteered to baby sit for you")
  end

  #if someone rejects a request notify the request owner and then re-send the new request email
  def reject_request_email(request, user_email, volunteer_email)
    @volunteer_email = volunteer_email
    @user_email = user_email
    @request = request
    mail(:to => user_email, :subject => "Your friend #{volunteer_email} can no longer baby sit for you")
  end

  #if some changes their dates send out the new request email and contact the volunteer if there is one
  def datechange_request_email(previous, new)
    @url = "http://www.helpmegoout.co.uk/request/#{new.id}/edit"
    @previous = previous
    @new = new
    mail(:to => previous.volunteer.email, :subject => "The dates have changed for your baby sitting")
  end

end
