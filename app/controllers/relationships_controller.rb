class RelationshipsController < ApplicationController
  before_action :ensure_guest_user

  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def followings
    user=User.find(params[:user_id])
    @users=user.followings.where(is_deleted:false)
  end

  def followers
    user=User.find(params[:user_id])
    @users=user.followers.where(is_deleted:false)
  end

  private

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to request.referer, notice: 'ゲストユーザーはこの機能を使用できません。'
    end
  end

end
