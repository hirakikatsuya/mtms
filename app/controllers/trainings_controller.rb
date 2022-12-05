class TrainingsController < ApplicationController
  before_action :authenticate_user!
  before_action :is_matching_login_user, only:[:edit, :update]

  def new
    @training=Training.new
  end

  def create
    @training=Training.new(training_params)
    @training.user_id=current_user.id
    if  @training.save
      flash[:notice]="トレーニングを保存しました！"
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def index
    @trainings=Training.all
  end

  def show
    @training=Training.find(params[:id])
    @user=@training.user
    @comment=Comment.new
  end

  def edit
    @training=Training.find(params[:id])
  end

  def update
    @training=Training.find(params[:id])
    if @training.update(training_params)
      flash[:notice]="トレーニングを編集しました！"
      redirect_to user_path(current_user)
    else
      render :edit_training_path
    end
  end

  def destroy
    @training=Training.find(params[:id])
    @training.destroy
    redirect_to trainings_path
  end

  private

  def training_params
    params.require(:training).permit(:title, :body, :training_day, :training_image)
  end

  def is_matching_login_user
    training=Training.find(params[:id])
    unless training.user == current_user
      redirect_to trainings_path
    end
  end

end
