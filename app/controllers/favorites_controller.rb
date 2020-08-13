class FavoritesController < ApplicationController
  before_action :post_params

  def create
    favorite = current_user.favorites.build(post_id: params[:post_id])
    favorite.save

    post = Post.find(params[:post_id])
    post.create_notification_like!(current_user)
  end

  def destroy
    favorite = Favorite.find_by(post_id: params[:post_id], user_id: current_user.id)
    favorite.destroy
  end

  def post_params
    @post = Post.find(params[:post_id])
  end
end
