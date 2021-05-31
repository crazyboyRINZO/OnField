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
    if session[:event]  && session[:event] != nil

p session[:event]

      @events = session[:event].where(start_time: @date_time)
      @events.page(params[:page]).per(10)



      # @events = Array.new
      # session[:event].each do |e|
      #   if Post.find(e).start_time == @date_time
      #     event = Post.find(e)
      #     @events.push(event)
      #   end
      # end
      
    else
      @events= Post.where(start_time: @date_time).page(params[:page]).per(10)
    end
  end

  def show_search
    @date_time = params[:time].to_datetime
    @events = Post.where(start_time: @date_time).where("title LIKE ? OR place LIKE ? OR contributor LIKE ?", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%").page(params[:page]).per(10)
    render :show
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
    @area = Post.group(:area).pluck(:area).sort
    @match = Post.group(:match).pluck(:match).sort
    @sports = Post.group(:sports).pluck(:sports).sort
  end

  def search
    @events = Post.where("area LIKE ? AND match LIKE ? AND sports LIKE ?", "%#{params[:area]}%", "%#{params[:match]}%", "%#{params[:sports]}%")
    if @events == []
      p '🌟🌟🌟'
      @events = []
      session[:event] = @events
      @area = Post.group(:area).pluck(:area).sort
      @match = Post.group(:match).pluck(:match).sort
      @sports = Post.group(:sports).pluck(:sports).sort
    else
      session[:event] = @events
      @area = Post.group(:area).pluck(:area).sort
      @match = Post.group(:match).pluck(:match).sort
      @sports = Post.group(:sports).pluck(:sports).sort
    end
    render :calender
  end

  def search_clear
    if session[:event] != nil
      session[:event] = nil
      redirect_to root_path
    else
      redirect_to root_path
    end
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
    @post.create_notification_post_taker!(current_solo, @post.solo_user_id)
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
    params.require(:post).permit(:title, :start_time, :match_start, :area, :place, :match, :sports, :category,
                                 :game_contents, :solo_user_id, :confirming ).merge(solo_user_id: current_user.id, contributor: current_solo.name)
  end

  def set_post
    @post = Post.find(params[:id])
  end

end
