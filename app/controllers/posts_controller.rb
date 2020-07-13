class PostsController < ApplicationController
  before_action :authenticate_user!
  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @posts = Post.all.order(created_at: "DESC")
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to posts_path
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end
end
