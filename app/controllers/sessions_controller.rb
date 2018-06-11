class SessionsController < ApplicationController
	def new
		
	end

	def create
		user = User.find_by(mob: params[:session][:mob])
		if user && user.authenticate(params[:session][:password])
			log_in user 
			remember user
			redirect_to user
		else
			flash.now[:danger] = "Mobile no or password invalid"
			render 'new'
		end

	end

	def destroy
		log_out if logged_in?
		redirect_to root_path
	end
end
