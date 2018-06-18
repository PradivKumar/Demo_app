class CommentsController < ApplicationController
	before_action :logged_in_user, only: [:create, :destroy]


	def create
		@comment = current_user.comments.new(post_id: params[:post_id], content: params[:content])
		if params[:content].empty? || params[:content].blank?
			flash[:danger] = "Comment!"
			redirect_to index_path
		elsif @comment.save
			redirect_to index_path
		end
	end
	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
		flash[:success] = "Comment deleted!"
		redirect_to index_path
	end


end
