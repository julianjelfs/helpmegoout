class UserMailer < ActionMailer::Base
  default from: "chiefbabysitter@helpmegoout.co.uk"

  def invitation_email(user, candidate)
    @user = user
    @candidate = candidate
    @url = "http://www.helpmegoout.co.uk/users/sign_up"
    mail(:to => candidate.email, :subject => "You have been invited to join Help Me Go Out")
  end
end
