class Users::SessionsController < Devise::SessionsController
  before_action :reject_user, only: [:create]

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(user), notice: "guestuserでログインしました!"
  end

  protected

  def reject_user
    @user=User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.is_deleted==true)
        flash[:notice] = "利用を停止しています"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "入力が正しくありません"
      end
    end
  end

end