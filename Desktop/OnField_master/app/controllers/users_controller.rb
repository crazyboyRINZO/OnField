class UsersController < ApplicationController
    before_action :authenticate_user!

    # ーーーーーフォロー関係ーーーーー
def follow
    @user = User.find(params[:id])
    current_user.follow(@user)
end

def unfollow
    @user = User.find(params[:id])
    current_user.stop_following(@user)
    redirect_to user_path(@user)
end

def follow_list
    @user = User.find(params[:id])
end

def followers_list
    @user = User.find(params[:id])
end

def mutual
end

    # ーーーーーユーザー関係ーーーーー
def show
    @user = User.find(params[:id])
end

def index
    @user = User.where.not(id:current_user.id)
end


end
