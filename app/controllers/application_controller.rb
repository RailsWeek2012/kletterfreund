class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def require_login! 
    unless user_signed_in?
      redirect_to login_path, alert: "Sie muessen eingeloggt sein, um diese Funktion zu nutzen."
    end
  end
  
  def current_user
    if session[:user_id]
     @current_user ||= User.find(session[:user_id])
    end
  end
  
  def user_signed_in?
    current_user.present?
  end

  def  current_user_email
    current_user.email
  end
  
  helper_method :require_login!
  helper_method :user_signed_in?
  helper_method :current_user_email 
end
