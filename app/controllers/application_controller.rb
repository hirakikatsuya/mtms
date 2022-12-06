class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except:[:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :reject_user, only: [:create]

  def after_sign_in_path_for(resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def reject_user
    @user=User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && (@user.active_for_authentication? == false)
        flash[:notice] = "利用を停止しています"
        redirect_to new_user_registration_path
      else
        flash[:notice] = "入力が正しくありません"
      end
    end
  end

end
