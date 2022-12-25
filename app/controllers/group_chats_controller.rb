# frozen_string_literal: true

class GroupChatsController < ApplicationController
  before_action :ensure_guest_user

  def index
    @group = Group.find(params[:id])
    @group_chats = @group.group_chats
    @group_chat = GroupChat.new
  end

  def create
    @group = Group.find(params[:id])
    @group_chat = current_user.group_chats.new(group_chat_params)
    @group_chat.group_id = @group.id
    if @group_chat.save
          @group = Group.find(params[:id])
    @group_chats = @group.group_chats
      @group_chat = current_user.group_chats.new(group_chat_params)
    else
          @group = Group.find(params[:id])
    @group_chats = @group.group_chats
      @group_chat = current_user.group_chats.new(group_chat_params)
    end
  end

  def destroy
    current_user.group_chat.find(params[:id]).destroy
  end

  private
    def group_chat_params
      params.require(:group_chat).permit(:chat, :chat_image)
    end
end
