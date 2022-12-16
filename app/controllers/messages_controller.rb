class MessagesController < ApplicationController
  before_action :ensure_guest_user

  def show
    @user = User.find(params[:id])
    rooms = current_user.user_rooms.pluck(:room_id)
    user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)

    if user_rooms.nil?
      @room = Room.new
      @room.save
      UserRoom.create(user_id: @user.id, room_id: @room.id)
      UserRoom.create(user_id: current_user.id, room_id: @room.id)
    else
      @room = user_rooms.room
    end

    @messages = @room.messages
    @message = Message.new(room_id: @room.id)
  end

  def create
    @message = current_user.messages.new(message_params)
    if @message.save
      redirect_to request.referer
    else
      @user = User.find(params[:id])
      rooms = current_user.user_rooms.pluck(:room_id)
      user_rooms = UserRoom.find_by(user_id: @user.id, room_id: rooms)
      @room = user_rooms.room
      @messages = @room.messages
      render :show
    end
  end

  def destroy
    current_user.messages.find(params[:id]).destroy
  end

  private

  def message_params
    params.require(:message).permit(:message,:message_image, :room_id)
  end

end
