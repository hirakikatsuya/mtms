class FavoritesController < ApplicationController
  before_action :ensure_guest_user
  
  def create
    @training=Training.find(params[:training_id])
    favorite=current_user.favorites.new(training_id:@training.id)
    favorite.save
  end

  def destroy
    @training=Training.find(params[:training_id])
    favorite=current_user.favorites.find_by(training_id:@training.id)
    favorite.destroy
  end
  
  private
  
  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to request.referer, notice: 'ゲストユーザーはこの機能を使用できません。'
    end
  end

end
