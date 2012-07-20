class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save 
      redirect_to home_path, notice: "Sie haben sich erfolgreich registriert."
    else
      render "new"
    end

  end
end
