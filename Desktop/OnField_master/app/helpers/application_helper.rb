module ApplicationHelper

    def current_solo(solo)
        SoloUser.find(solo)
    end


end
