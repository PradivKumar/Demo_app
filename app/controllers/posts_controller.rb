class PostsController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Successfully posted!"
			redirect_to root_url
		else
			render 'users/index'
		end
	end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted!"
		redirect_to root_url
	end

	private
	def post_params
		params.require(:post).permit(:content)
	end
def logged_in_user
		if !logged_in?
			flash[:danger] = "Please Login!"
			redirect_to login_path
		end	
	end
	def correct_user
		@post = current_user.posts.find_by(id: params[:id])
		redirect_to root_url if @post.nil?
	end
end
