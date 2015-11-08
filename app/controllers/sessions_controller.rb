class SessionsController < ApplicationController
  def new
  end

  def create
  	admin = Admin.find_by(login: params[:session][:login])
  	if admin && admin.authenticate(params[:session][:password])
  		log_in admin
  		remember admin
  		redirect_to users_path
  	else
  		flash.now[:danger] = 'Invalid login/password combination'
  		render 'new'
  	end
  end

  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
end
