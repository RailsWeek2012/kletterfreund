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

  
  def uiaa_grades
      ["keine Angabe", "I", "II", "III", "IV", "IV+", "V", "V+", "VI-", "VI", "VI+", "VII-", "VII", "VII+", "VIII", "VIII+", "IX-", "IX",
       "IX+", "X-", "X", "X+", "XI-", "XI", "XI+"]
  end

  def french_grades
    ["keine Angabe", "1", "2", "3", "4a", "4b", "4c", "5a", "5b", "5c", "6a", "6a+", "6b", "6b+", "6c/6c+", "7a", "7a+", "7b+", "7c", 
      "7c+", "8a+", "8b", "8b+", "8c+", "9a", "9a+"]
  end

  def yds_grades
    ["keine Angabe", "5.1", "5.2", "5.3", "5.4", "5.5", "5.6", "5.7", "5.8", "5.9", "5.10a", "5.10b", "5.10c", "5.10d", "5.11b", "5.11d", "5.12a", "5.12c", "5.12d", 
      "5.13a", "5.13c", "5.13d", "5.14a", "5.14c", "5.14d", "5.15a"]
  end

  helper_method :uiaa_grades
  helper_method :french_grades
  helper_method :yds_grades
end
