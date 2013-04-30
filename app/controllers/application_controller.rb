class ApplicationController < ActionController::Base
  protect_from_forgery  
  
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def user_signed_in?
    @current_user
  end
  
  helper_method :current_user
  helper_method :user_signed_in?

end
