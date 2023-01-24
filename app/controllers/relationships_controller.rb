# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :ensure_guest_user
  before_action :user_is_deleted?

  def create
    @user=User.find(params[:user_id])
    current_user.follow(params[:user_id])
  end

  def destroy
    @user=User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.where(is_deleted: false)
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.where(is_deleted: false)
  end

  private

  def user_is_deleted?
    user = User.find(params[:user_id])
    if current_user.admin == false && user.is_deleted == true
      flash[:notice] = "このユーザーは利用停止されています"
      redirect_to users_path
    end
  end

end
