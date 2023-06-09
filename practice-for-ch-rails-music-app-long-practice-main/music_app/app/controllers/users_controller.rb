class UsersController < ApplicationController

  
    def index
      @users = User.order(:email)
    end
  
    def show
    end
  
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
  
      if @user.save
        login!(@user)
        redirect_to root_url

      else
        
        render :new
      end
    end

  
    private
  
    def user_params
      params.require(:user).permit(:email, :password)
    end
  end