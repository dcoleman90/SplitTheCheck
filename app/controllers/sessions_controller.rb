class SessionsController < ApplicationController
  skip_before_action :authorize
  
  # GET sessions/new
  def new
  end

  # GET sessions/create
  def create
  	user = User.find_by(email: params[:email])
	if user.try(:authenticate, params[:password]) && user.id == 4
  		session[:is_admin] = true
  		session[:user_id] = user.id	
  		redirect_to restaurants_url
  	elsif user.try(:authenticate, params[:password])
  		session[:is_admin] = false
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
  	session[:is_admin] = nil
  	redirect_to restaurants_url, notice: "Logged out"
  end
end
