class FeedbackMailer < ActionMailer::Base
  default :from => 'feedback@helpmegoout.co.uk'

  def feedback(feedback)
    @feedback = feedback
    mail(:to => 'julian.jelfs@gmail.com', :subject => '[Feedback for YourSite] #{feedback.subject}')
  end
end
