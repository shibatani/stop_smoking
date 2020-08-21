class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to posts_path
  end

  def index
    @post = Post.new
    @posts = Post.all.includes(:favorites, :comments, :user).order(created_at: "DESC")
  end

  def show
    @post = Post.find(params[:id])
    @comment = Comment.new
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
