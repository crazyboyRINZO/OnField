class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @rooms = Room.where(solo_user_id: current_user.id).or(Room.where(partnar_id: current_user.id))
  end

  def show
    @room = Room.find(params[:id])
    @user = @room.solo_user
    @messages = @room.messages
  end

  def new
    post_taker = PostTaker.find_by(taker_id: current_user.id)
    @room = Room.create
    redirect_to rooms_path
  end
end