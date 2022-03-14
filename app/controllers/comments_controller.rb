class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.set_user_id(login_user_id: session[:id])
    @comment.set_post_id(pid: params[:pid])
    if @comment.save
      redirect_to posts_show_path(params[:pid])
    else
      @post = Post.find_by(pid: params[:pid])
      @comments = @post.comments.include_user.id_desc
      render 'posts/show', status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to posts_show_path(@comment.post.pid)
  end

  def comment_params
    params.permit(:content)
  end
end
