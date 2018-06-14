class RelationshipsController < ApplicationController
	before_action :logged_in_user
	#before_action :blocked

	def create
		@user = User.find(params[:followed_id])
		@rel = Relationship.find_by(follower: current_user, followed: @user)
		byebug
		if @rel.present? && @rel.block == 2
			flash.now[:danger] = "Unblock!"
		else
			current_user.follow(@user)
			@rel = Relationship.find_by(follower: current_user, followed: @user)
			if @rel.update_attributes(block: params[:block])
				redirect_to @user
			end 
		end
		#respond_to do |format|
      #format.html { redirect_to @user }
      #format.js
    #end
    
	end

	def destroy
		@user = Relationship.find(params[:id]).followed
		current_user.unfollow(@user)
	#	 respond_to do |format|
    ##  format.html { redirect_to @user }
     # format.js
    redirect_to @user
    end

    def update
    	#byebug
    	@user = User.find(params[:followed_id])
    	@rel = Relationship.find_by(follower: current_user, followed_id: params[:followed_id])
    	if @rel.update_attributes(block: params[:block])
    		redirect_to @user
    	end
    end



end
