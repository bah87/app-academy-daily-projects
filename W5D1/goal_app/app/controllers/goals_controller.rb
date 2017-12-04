class GoalsController < ApplicationController
  def new
  end

  def create
    goal = Goal.new(goal_params)
    goal.user_id = current_user.id
    if goal.save
      redirect_to goal_url(goal)
    else
      flash[:errors] = goal.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    goal = current_user.goals.find_by(id: params[:id])
    
    if goal && goal.update_attributes(goal_params)
      redirect_to goal_url(goal)
    else
      flash[:errors] = goal.errors.full_messages
      render :edit
    end
  end

  def index
  end

  def destroy
    goal = current_user.goals.find_by(id: params[:id])
    unless goal && goal.destroy
      flash[:errors] = goal.errors.full_messages
    end
    
    redirect_to(user_url(current_user))
  end
  
  private
  def goal_params
    params.require(:goal).permit(:title, :details, :private, :completed)
  end
end
