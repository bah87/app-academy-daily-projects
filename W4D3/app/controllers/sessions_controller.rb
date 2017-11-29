class SessionsController < ApplicationController
  
  before_action :redirect_if_logged_in, only: :new
  
  def new
  end
  
  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password]
    )
    if user
      login(user)
      redirect_to cats_url
    else
      render :new
    end
  end
  
  def destroy
    if current_user
      current_user.reset_session_token!
      session[:session_token] = nil
      @current_user = nil
    end
    redirect_to new_session_url
  end
end