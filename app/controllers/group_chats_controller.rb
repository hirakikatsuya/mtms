class GroupChatsController < ApplicationController
  before_action :ensure_guest_user

  def index
    @group=Group.find(params[:id])
    @group_chats=@group.group_chats
    @group_chat=GroupChat.new
  end

  def create
    @group=Group.find(params[:id])
    @group_chat=current_user.group_chats.new(group_chat_params)
    @group_chat.group_id=@group.id
    @group_chat.save
    redirect_to request.referer
  end

  def destroy
    current_user.group_chat.find(params[:id]).destroy
  end

  private

  def group_chat_params
    params.require(:group_chat).permit(:chat)
  end

  def ensure_guest_user
    if current_user.name == "guestuser"
      redirect_to request.referer, notice: 'ゲストユーザーはこの機能を使用できません。'
    end
  end

end
