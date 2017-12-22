class UsersController < ApplicationController
  def new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      login_user!(@user)
      #redirect_to ... # later will want to redirect to main page
      # for now just send them to their show page
      render :show
    else
      render :new
    end
  end
  
  def show
    @user = User.find_by(id: params[:id])
    render :show
  end
  
  private
  def user_params
    params.require(:user).permit(:email, :password)
  end
end