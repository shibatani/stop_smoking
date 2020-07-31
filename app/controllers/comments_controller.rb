class CommentsController < ApplicationController
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.user_id = current_user.id
    @comment_post = @comment.post

    if @comment.save
      @comment_post.create_notification_comment!(current_user, @comment.id)
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
end
