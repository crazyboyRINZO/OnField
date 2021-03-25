class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:index,:new, :create, :back, :comp, :details]

  def index
    @events = Post.all
  end

  def new
    @event = Post.new
  end

  def show
    @date_time = params[:start_time].to_datetime
    @event = Post.where(start_time: @date_time)
  end

  def create
    @event = Post.new(post_params)
    if @event.save
      redirect_to posts_comp_path
    else 
      session[:post] = @event
      render :new
    end
  end

  def back
    @event = Post.new(session[:post])
    session.delete(:post)
    render :new
  end

  def calender
    @events = Post.all
  end

  def comp
  end

  def details
    set_post
    @event = Post.find_by(id:params[:id])
    @comments = @post.comments
    @comment = @post.comments.build
    @user = @post.solo_user
  end

  def take
    set_post
    PostTaker.create(post_id: @post.id, taker_id: current_user.id)
    Room.create!(post_id: @post.id, solo_user_id: current_user.id, partnar_id: @post.solo_user_id)
    flash[:notice] = '申し込みが完了しました。'
    redirect_to action: "details"
  end

  def cancel
    set_post
    post_taker = PostTaker.find_by(post_id: @post.id, taker_id: current_user.id)
    room = Room.find_by(post_id: @post.id, solo_user_id: current_user.id)
    post_taker.destroy
    room.destroy
    flash[:notice] = 'キャンセルが完了しました。'
    redirect_to action: "details"
  end

  private

  def post_params
    params.require(:post).permit(:title, :start_time, :match_start, :deadline, :area, :place, :level,
                                  :game_contents, :game_image, :solo_user_id, :confirming, :game_image_cache).merge(solo_user_id:current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
