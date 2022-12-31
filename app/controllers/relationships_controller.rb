# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :ensure_guest_user

  def create
    @user=User.find(params[:user_id])
    current_user.follow(params[:user_id])
  end

  def destroy
    @user=User.find(params[:user_id])
    current_user.unfollow(params[:user_id])
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings.where(is_deleted: false)
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers.where(is_deleted: false)
  end
end
