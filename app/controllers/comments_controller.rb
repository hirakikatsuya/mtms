class CommentsController < ApplicationController
    before_action :ensure_guest_user

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

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to request.referer, notice: 'ゲストユーザーはこの機能を使用できません。'
    end
  end

  def comment_params
    params.require(:comment).permit(:comment)
  end

end
