class ApplicationController < ActionController::Base
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id].present?
  end

  private

  def authenticate_user
    redirect_to root_path unless current_user.present?
  end
end
