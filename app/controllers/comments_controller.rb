class CommentsController < ApplicationController

  def create
    @training=Training.find(params[:training_id])
    @comment=Comment.new(comment_params)
    @comment.user_id=current_user.id
    @comment.training_id=@training.id
    @comment.save

  end

  def destroy
    @comment=Comment.find(params[:id])
    @comment.destroy
    @training=Training.find(params[:training_id])
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
