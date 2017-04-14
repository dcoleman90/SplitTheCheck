class SessionsController < ApplicationController
  skip_before_action :authorize
  
  # GET sessions/new
  def new
  end

  # GET sessions/create
  def create
  	user = User.find_by(email: params[:email])
  	if user.try(:authenticate, params[:password])
  		session[:user_id] = user.id
  		redirect_to restaurants_url
  	else
  		redirect_to login_url, 
  			alert: "Invalid user/password combination"
  	end
  end

  # GET sessions/destroy
  def destroy
  	session[:user_id] = nil
  	redirect_to restaurants_url, notice: "Logged out"
  end
end
