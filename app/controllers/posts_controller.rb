class PostsController < ApplicationController
    
    before_action :set_post, only: [:create, :edit, :update, :destroy]
    
    
    def create
        @post = current_user.posts.new(post_params)
        if @post.save
            respond_to do |format|
                format.html {redirect_to user_path(@post.user.username), notice: "Post Created"}
            end
        else
            redirect_to user_path(@post.user.username), notice: "Something went wrong."
        end
    end
    
    # define edit of post
    def edit
    end
    
    # define the update of a post
    def update
        if @post.update(post_params)
            respond_to do |format|
                format.html {redirect_to user_path(@post.user.username), notice: "Post Updated"}
            end
        else
            redirect_to post_path(@post), notice: "Something went wrong."
        end
    end
    
    # define the destroy method of the post
    def destroy
        @post.destroy
        respond_to do |format|
            format.html {redirect_to user_path(@post.user.username), notice: "Post Destroyed"}
        end
    end
    
    private
    
    def set_post
        @post = Post.find(params[:id])
    end
    
    def post_params
        params.require(:post).permit(:content)
    end
    
end