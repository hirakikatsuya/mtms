class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except:[:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?

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

  def ensure_guest_user
    if current_user.name == "guestuser"
      flash[:notice]="ゲストユーザーはこの機能を使用できません。"
      redirect_to request.referer
    end
  end

end
