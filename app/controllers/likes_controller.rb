class LikesController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]

	def create
		@post = Post.find(params[:post_id])
		@post.likes.create(user: current_user)
		redirect_to users_path
	end
	def destroy
		post = Like.find(params[:id])
		post.delete if post.user_id == current_user.id
		redirect_to users_path
	end
end
