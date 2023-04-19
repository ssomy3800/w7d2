class ApplicationController < ActionController::Base
  
    helper_method :current_user, :logged_in?

    def current_user
      @current_user ||= User.find_by(id: session[:user_id])
    end
  

    def logged_in?
      !current_user.nil?
    end

    def log_in(user)
      user.reset_session_token! 
      session[:user_id] = user.id 
    end
  
    def log_out
      session[:user_id] = nil 
      @current_user = nil 
    end
  end
  