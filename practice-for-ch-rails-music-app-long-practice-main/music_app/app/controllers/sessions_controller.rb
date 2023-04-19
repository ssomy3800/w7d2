class SessionsController < ApplicationController

  
    def create
      user = User.find_by_credentials(
        params[:user][:email],
        params[:user][:password]
      )
  
      if user.nil?
        flash.now[:errors] = ["No such user."]
        render :new

      elsif !user.activated?
        flash.now[:errors] = ['Invalid email or password']
        render :new
      else
        login!(user)
        redirect_to root_url
      end
    end
  
    def destroy
      current_user.try(:reset_session_token!)
      session[:session_token] = nil
  
      redirect_to new_session_url
    end
  end