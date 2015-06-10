class UsersController < ApplicationController
  
  before_action :authenticate_user!, only: [:index]
  before_action :set_user, only: [:show]
  
  # read url parameters: /users?people=pending
  def index
    case params[:people] 
      when "friends"
        @users = current_user.active_friends
      when "requests"
        @users = current_user.pending_friend_requests_from.map(&:user)
      when "pending"
        @users = current_user.pending_friend_requests_to.map(&:friend)
      else
        #display all people except yourself
        @users = User.where.not(id: current_user.id)
    end
  end
  
  def show
    # Get posts
    @post = Post.new
    @posts = @user.posts
    # Get all activities relative to the user
    @activities = PublicActivity::Activity.where(owner_id: @user.id) + PublicActivity::Activity.where(recipient_id: @user.id)
  end
  
  private
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
  
end
