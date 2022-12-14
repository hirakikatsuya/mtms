# frozen_string_literal: true

class GroupsController < ApplicationController
  before_action :group_find, only: [:show, :edit, :update, :destroy, :join, :leave]
  before_action :owner_user, only: [:edit, :destroy]
  before_action :ensure_guest_user, except: [:show, :index]

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    if @group.save
      @group.users << current_user
      flash[:notice] = "グループを作成しました！"
      redirect_to group_path(@group.id)
    else
      render :new
    end
  end

  def index
    @groups = Group.page(params[:page]).per(10)
  end

  def show
    @users = @group.users.where(is_deleted: false).page(params[:page]).per(10)
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:notice] = "グループ情報を更新しました！"
      redirect_to group_path(@group.id)
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_path
  end

  def join
    @group.users << current_user
    flash[:notice] = "グループに参加しました！"
    redirect_to group_path(@group.id)
  end

  def leave
    @group.users.delete(current_user)
    flash[:notice] = "グループを抜けました"
    redirect_to groups_path
  end

  private
    def group_params
      params.require(:group).permit(:group_name, :group_explain, :group_image)
    end

    def group_find
      @group = Group.find(params[:id])
    end

    def owner_user
      @group = Group.find(params[:id])
      unless @group.owner_id == current_user.id || current_user.admin
        flash[:notice] = "この機能は利用できません。"
        redirect_to groups_path
      end
    end
end
