class PostsController < ApplicationController
  before_action :already_login?, except: [:index, :new, :create, :show, :destroy]
  def index
    sort = post_sort_params[:sort]
    @sort_selected = sort
    post = Post.new
    @posts = post.posts_sort(sort: sort)
  end

  def create
    @post = Post.new(post_create_params)
    @post.user_id = session[:id]
    if @post.save
      redirect_to posts_path
    else
      @posts = Post.posts_sort(sort: nil)
      render 'index', status: :unprocessable_entity
    end
  end

  def show
    @post = Post.find_by(pid: params[:pid])
    @comments = @post.comments.include_user.id_desc
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private
  def post_sort_params
    params.permit(:sort)
  end

  private
  def post_create_params
    params.permit(:content)
  end
end
