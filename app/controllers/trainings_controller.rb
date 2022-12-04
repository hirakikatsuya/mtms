class TrainingsController < ApplicationController

  def new
    @training=Training.new
  end

  def create
    @training=Training.new(training_params)
    @training.user_id=current_user.id
    if  @training.save
      flash[:notice]="トレーニングを保存しました！"
      redirect_to users_path
    else
      render :new_path
    end
  end

  private

  def training_params
    params.require(:training).permit(:title, :body, :training_day, :training_image)
  end

end
