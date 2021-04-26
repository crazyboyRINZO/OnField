class UsersController < ApplicationController
    before_action :authenticate_user!

    # ーーーーーユーザー関係ーーーーー
def show
    @user = User.find(params[:id])
end

def index
    @user = User.where.not(id:current_user.id)
end


end
