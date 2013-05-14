module CircleHelper
  def is_me(user)
    user == current_user
  end
end