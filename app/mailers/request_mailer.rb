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
  def delete_request_email(request)

  end

  #if someone accepts the request email the request owner and let them know
  def accept_request_email(request)

  end

  #if someone rejects a request notify the request owner and then re-send the new request email
  def reject_request_email(request)

  end

  #if some changes their dates send out the new request email and contact the volunteer if there is one
  def edit_request_email(request)

  end

end
