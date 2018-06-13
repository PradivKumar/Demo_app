class PostsController < ApplicationController

	before_action :logged_in_user, only: [:create, :destroy]
	before_action :correct_user, only: :destroy
	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			flash[:success] = "Successfully posted!"
			redirect_to root_url
		else
			@feed_items = []
			render 'users/index'
		end
	end

	def destroy
		@post.destroy
		flash[:success] = "Post deleted!"
		redirect_to current_user
	end

	def up
		@post = Post.find(params[:id])
		@post.upvote_from current_user
		redirect_to index_path
	end

	def down
		@post = Post.find(params[:id])
		@post.downvote_from current_user
		redirect_to index_path
	end

	def undo
		@post = Post.find(params[:id])
		@vote = @post.votes_for.find_by(voter_id: current_user.id)
		@vote.destroy
		redirect_to index_path
	end

	private
	def post_params
		params.require(:post).permit(:content, :picture)
	end

	def correct_user
		@post = current_user.posts.find_by(id: params[:id])
		redirect_to root_url if @post.nil?
	end
end
