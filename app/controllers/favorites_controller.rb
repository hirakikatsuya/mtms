class FavoritesController < ApplicationController

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

end
