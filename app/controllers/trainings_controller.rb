class TrainingsController < ApplicationController
  before_action :is_matching_login_user, only:[:edit,:update,:destroy]
  before_action :training_find,only:[:show,:edit,:update,:destroy]
  before_action :ensure_guest_user, except:[:index, :show]

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
    if params[:tag].present?
      @tag=Tag.find(params[:tag])
      @trainings=Tag.find(params[:tag]).trainings.active_users.page(params[:page]).per(10)
    else
      @trainings=Training.active_users.page(params[:page]).per(10)
    end
  end

  def show
    @user=@training.user
    @comment=Comment.new
  end

  def edit
  end

  def update
    if @training.update(training_params)
      flash[:notice]="トレーニングを編集しました！"
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @training=Training.find(params[:id])
    @training.destroy
    flash[:notice]="トレーニングを削除しました"
    redirect_to  user_path(current_user)
  end

  private

  def training_params
    params.require(:training).permit(:title, :body, :start_time, :training_image, tag_ids:[])
  end

  def is_matching_login_user
    training=Training.find(params[:id])
    unless training.user == current_user || current_user.admin==true
      flash[:notice]="このページへは遷移出来ません"
      redirect_to trainings_path
    end
  end

  def training_find
    @training=Training.find(params[:id])
  end

end
