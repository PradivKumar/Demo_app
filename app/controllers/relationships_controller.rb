class RelationshipsController < ApplicationController
	before_action :logged_in_user
	#before_action :blocked

	def create
		@user = User.find(params[:followed_id])
		@rel = Relationship.find_by(follower: current_user, followed: @user)
		
		if @rel.present? && @rel.block == 2
			flash[:danger] = "Unblock!"
			respond_to do |format|
  format.js {render inline: "location.reload();" }
end
		else
			current_user.follow(@user)
			@rel = Relationship.find_by(follower: current_user, followed: @user)
			if @rel.update_attributes(block: params[:block])
				respond_to do |format|
  format.js {render inline: "location.reload();" }
end
			end 
		end
		
    
	end

	def destroy
		#byebug
		@user = Relationship.find(params[:id]).followed
		@rel = Relationship.find_by(follower: current_user, followed: @user)
		if params[:block] == 3
			current_user.unfollow(@user)
			respond_to do |format|
  format.js {render inline: "location.reload();" }
end
		elsif @rel.present? && @rel.block == 1
				if @rel.update_attributes(block: 0)
				respond_to do |format|
  format.js {render inline: "location.reload();" }
end
				end
		else
		current_user.unfollow(@user)
	#	 respond_to do |format|
    ##  format.html { redirect_to @user }
     # format.js
  respond_to do |format|
  format.js {render inline: "location.reload();" }
end
    end
end

    def update
    	#byebug
    	@user = User.find(params[:followed_id])
    	@rel = Relationship.find_by(follower: current_user, followed_id: params[:followed_id])
    	if @rel.update_attributes(block: params[:block])
    	respond_to do |format|
  format.js {render inline: "location.reload();" }
end
    	end
    end



end
