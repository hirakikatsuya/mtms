class Api::MessagesController < ApplicationController
  def show
    @room = Room.find(params[:room_id])
    @messages = @room.messages.includes(:user).where('id > ?', params[:id])
    respond_to do |format|
      format.html
      format.json
    end
  end
end