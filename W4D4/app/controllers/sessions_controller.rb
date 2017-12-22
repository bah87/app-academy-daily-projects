class SessionsController < ApplicationController
  def new
  end
  
  def create
    email = params[:user][:email]
    password = params[:user][:password]
    @user = User.find_by_credentials(email, password)
    if @user
      login_user!(@user)
      redirect_to user_url(@user)
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