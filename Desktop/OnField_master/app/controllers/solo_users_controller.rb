class SoloUsersController < ApplicationController
  before_action :authenticate_user!

    def index
      @solo_user = SoloUser.new(session[:solo_user])
      session.delete(:solo_user)
      render :new
    end

    def new
        @solo_user = SoloUser.new
    end

    def create
        @solo_user = SoloUser.new(solo_user_params)
        if @solo_user.save
          redirect_to solo_users_comp_path
        else
          session[:solo_user] = @solo_user
          render :new
        end
      end
    
    def back
        @solo_user = SoloUser.new(session[:solo_user])
        session.delete(:solo_user)
        render :new
    end

    def show
      @solo_user = SoloUser.find_by(user_id: params[:id])
    end

    def edit
      @solo_user = SoloUser.find(params[:id])
    end

    def update
      @solo_user = SoloUser.find(params[:id])
       
      #編集しようとしてるユーザーがログインユーザーとイコールかをチェック
      if current_user == @solo_user
       
        if @solo_user.update!(solo_user_params)
          flash[:success] = 'ユーザー情報を編集しました。'
          render :edit
        else
          flash.now[:danger] = 'ユーザー情報の編集に失敗しました。'
          render :edit
        end
       
      else
          redirect_to root_path
      end
      end
    
    private

    def solo_user_params
        params.require(:solo_user).permit(:user_id, :name, :contents, :sports, :user_image, :category, :confirming, :place, :level).merge(user_id:current_user.id)
    end

end

