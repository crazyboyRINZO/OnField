class TeamsController < ApplicationController
  before_action :authenticate_user!

    def new
        @team = Team.new
    end

    def create
        @team = Team.new(team_params)
        if @team.save
          redirect_to teams_comp_path
        else
          session[:team] = @team
          render :new
        end
      end
    
    def back
        @team = Team.new(session[:team])
        session.delete(:team)
        render :new
    end

    private

    def team_params
        params.require(:team).permit(:team_name, :sports, :member, :team_level, :performance, :team_contents,
                                            :team_image, :men, :women, :team_image_cache, :confirming)
    end

end
