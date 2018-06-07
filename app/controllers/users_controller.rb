class UsersController < ApplicationController

	before_action :logged_in_user, only: [:edit, :update , :show]

	def index

	

	end

	def front
			@users = User.paginate(page: params[:page], per_page: 2)
	end

	def new
		@user = User.new 
	end

	def create
		@user = User.new(allowed_params)
		if @user.save 
			log_in @user
			flash[:success] = "Signed up Successfully!"
			redirect_to @user
			
		else
			
			render 'new'
	end
end

	def show
		@user = User.find(params[:id]) 

	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(allowed_params)
			flash[:success] = "Updated Successfully"
			redirect_to @user
		else
			render 'edit'
		end
	end

	def destroy
		User.find(params[:id]).destroy
		redirect_to users_path
	end

	private
	def allowed_params
		params.require(:user).permit(:name, :mob, :password, :password_confirmation)
	end

	def logged_in_user
		if !logged_in?
			flash[:danger] = "Please Login!"
			redirect_to login_path
		end	
	end
end
