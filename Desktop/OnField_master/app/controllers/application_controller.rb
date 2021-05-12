class ApplicationController < ActionController::Base
    before_action :configure_permitted_parameters, if: :devise_controller?
    protect_from_forgery with: :exception
  
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:email, :password, :password_confirmation, :accepted)}
    end

    def current_solo
      SoloUser.find_by(user_id: current_user.id)
    end

    def self.render_with_signed_in_user(user, *args)
      ActionController::Renderer::RACK_KEY_TRANSLATION['warden'] ||= 'warden'
      proxy = Warden::Proxy.new({}, Warden::Manager.new({})).tap{|i| i.set_user(user, scope: :user) }
      renderer = self.renderer.new('warden' => proxy)
      renderer.render(*args)
    end


end
