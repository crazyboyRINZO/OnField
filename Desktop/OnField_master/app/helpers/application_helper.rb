module ApplicationHelper

  def current_solo
    SoloUser.find_by(user_id: current_user.id)
    
  end
    
end
