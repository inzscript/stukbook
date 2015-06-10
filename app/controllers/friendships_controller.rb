class FriendshipsController < ApplicationController

    # Ensure user is logged in
    before_action :authenticate_user!
    before_action :set_user, only: [:create]
    before_action :set_friendship, only: [:destroy, :accept]
        
	# Action to create a freindship request
	def create
		@friendship = current_user.request_friendship(@user)
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Created"}
		end
	end
	
	#Action to remove a friendship request and redirect to People page
	def destroy
	    @friendship.destroy
	    respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Deleted"}
		end
	end
	
	# Action to Accept friendship
	def accept
		@friendship.accept_friendship
		# initiate tracking of friendships uses public_activity
		@friendship.create_activity key: 'friendship.accepted', owner: @friendship.user, recipient: @friendship.friend
		respond_to do |format|
			format.html {redirect_to users_path, notice: "Friendship Accepted"}
		end
	end
	
	private
	
	def set_user
	    @user = User.find(params[:user_id])
	end
	
	def set_friendship
	    @friendship = Friendship.find(params[:id])
	end

end