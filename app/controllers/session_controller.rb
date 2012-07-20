class SessionController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: "Sie haben sich angemeldet"
    else 
      flash.now[:alert] = "Leider stimmt der Username oder das Passwort nicht."
      render action: "new" 
    end
  end

  def destroy
    session[:user_id] = nil
      redirect_to home_path,
      notice: "Sie haben sich ausgeloggt."
  end
end
