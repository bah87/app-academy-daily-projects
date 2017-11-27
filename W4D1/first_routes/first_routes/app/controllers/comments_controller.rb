class CommentsController < ApplicationController
  def index
    if comment_params[:user_id]
      found_comments = User.find(comment_params[:user_id]).comments
    elsif comment_params[:artwork_id]
      found_comments = Artwork.find(comment_params[:artwork_id]).comments
    else
      render json: ['Comments not found']
      return
    end
    render json: found_comments
  end
  
  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render json: comment.errors.full_messages, status: :unprocessable_entity
    end
  end
  
  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment
  end
  
  private
  def comment_params
    params.require(:comments).permit(:user_id, :artwork_id, :body)
  end
end