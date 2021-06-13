module ApplicationHelper
  def current_user
    return User.find(session[:user_id]) if session[:user_id].present?
  end

  def logged_in?
    !!session[:user_id]
  end
end
