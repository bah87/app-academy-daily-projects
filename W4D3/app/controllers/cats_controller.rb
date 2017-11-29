class CatsController < ApplicationController
  
  before_action :redirect_unless_logged_in, only: :new
  before_action :current_user_owns_cat?, only: [:update, :edit]
  
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.includes(:owner, {rental_requests: :user}).find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.owner_id = current_user.id
    if @cat.save
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :new
    end
  end

  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @cat = Cat.find(params[:id])
    if @cat.update_attributes(cat_params)
      redirect_to cat_url(@cat)
    else
      flash.now[:errors] = @cat.errors.full_messages
      render :edit
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:age, :birth_date, :color, :description, :name, :sex)
  end
  
  def current_user_owns_cat?
    @cat = Cat.find(params[:id])
    redirect_to cat_url(@cat) unless current_user && current_user.cats.include?(@cat)
  end
end
