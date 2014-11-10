class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def authorize
    unless current_user != nil
      flash[:notice] = "You need to be signed in first."
      redirect_to "/"
    end
  end

  def organization?
    current_user && current_user.type == "Organization"
  end

  def volunteer?
    current_user && current_user.type == "Volunteer"
  end

  helper_method :current_user, :organization?, :volunteer?
end
