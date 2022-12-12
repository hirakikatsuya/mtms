class UsersController < ApplicationController
  before_action :is_matching_login_user, only:[:edit, :update]
  before_action :ensure_guest_user, except:[:index, :show]
  before_action :admin_user,only: [:suspend,:unsuspend,:suspend_users,:destroy]
  before_action :user_is_deleted?,only: [:show]
  before_action :user_find,only: [:show,:edit,:update,:favorites,:suspend,:unsuspend,:destroy]

  def index
    @users=User.where(is_deleted:false).page(params[:page]).per(10)
  end

  def show
    @trainings=@user.trainings
  end

  def edit
  end

  def update
    if @user.update(user_params)
      flash[:notice]="ユーザー情報を更新しました！"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def favorites
    favorites=Favorite.where(user_id:@user.id).pluck(:training_id)
    @favorite_trainings=Training.find(favorites)
    @favorite_trainings=Kaminari.paginate_array(@favorite_trainings).page(params[:page]).per(10)
  end

  def suspend
    @user.update(is_deleted:true)
    flash[:notice]="利用停止にしました。"
    redirect_to users_path
  end

  def unsuspend
    @user.update(is_deleted:false)
    flash[:notice] ="利用停止を解除しました。"
    redirect_to users_path
  end

  def suspend_users
    @users=User.where(is_deleted:true)
  end

  def destroy
    @user.destroy
    redirect_to suspend_users_users_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to request.referer, notice: 'ゲストユーザーはこの機能を使用できません。'
    end
  end

  def is_matching_login_user
    user=User.find(params[:id])
    unless user == current_user
      redirect_to user_path(current_user)
      flash[:notice]="このページへは遷移できません"
    end
  end

  def admin_user
    unless current_user.admin?
    redirect_to (users_path)
    end
  end

  def user_is_deleted?
    user=User.find(params[:id])
    if current_user.admin==false && user.is_deleted==true
      flash[:notice]="このユーザーは利用停止されています"
      redirect_to users_path
    end
  end

  def user_find
    @user=User.find(params[:id])
  end

end