class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]
  before_action :ensure_guest_user, only: [:edit]
  before_action :search

  def index
    @users=User.all
  end

  def show
    @user=User.find(params[:id])
  end

  def edit
    @user=User.find(params[:id])
  end

  def update
    @user=User.find(params[:id])
    if @user.update(user_params)
      flash[:notice]="ユーザー情報を更新しました！"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def favorites
    @user=User.find(params[:id])
    favorites=Favorite.where(user_id:@user.id).pluck(:training_id)
    @favorite_trainings=Training.find(favorites)
  end


  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def is_matching_login_user
    user=User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user)
    end
  end

  def ensure_guest_user
    @user = User.find(params[:id])
    if @user.name == "guestuser"
      redirect_to user_path(current_user) , notice: 'ゲストユーザーはプロフィール編集画面へ遷移できません。'
    end
  end

end