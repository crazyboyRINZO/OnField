class SoloUsersController < ApplicationController
  before_action :authenticate_user!

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
      @solo_user = SoloUser.find(params[:id])
    end


    
    private

    def solo_user_params
        params.require(:solo_user).permit(:user_id, :name, :sex, :age, :contents, :sports, :school, :position,
                                            :experience, :user_image, :confirming, :user_image_cache).merge(user_id:current_user.id)
    end

end

