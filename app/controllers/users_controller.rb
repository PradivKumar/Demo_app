class UsersController < ApplicationController
	def index
	end

	def new
		@user = User.new 
	end

	def create
		@user = User.new(allowed_params)
		if @user.save
			 flash[:success] = "Signed up Successfully!"
			redirect_to @user
			
		else
			
			render 'new'
	end
end

	def show
		@user = User.find_by(params[:id]) 
	end

	private
	def allowed_params
		params.require(:user).permit(:name, :mob, :password, :password_confirmation)
	end
end
