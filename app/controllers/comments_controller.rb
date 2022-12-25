# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :ensure_guest_user

  def create
    @training = Training.find(params[:training_id])
    @comment = current_user.comments.new(comment_params)
    @comment.training_id = @training.id
    @comment.save
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    @training = Training.find(params[:training_id])
  end

  private
    def comment_params
      params.require(:comment).permit(:comment)
    end
end
