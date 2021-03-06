class ApplicationController < ActionController::Base
  protect_from_forgery

private

  def load_user
    @user = User.find_by_subdomain!(request.subdomain)
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user
end
