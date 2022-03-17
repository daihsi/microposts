class UsersController < ApplicationController
  before_action :already_login?, only: [:new, :create]
  before_action :login?, only: [:show]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:uid] = @user.uid
      session[:id] = @user.id
      redirect_to posts_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def show
    @user = User.find_by(uid: params[:uid])
    @follows = @user.following_user.id_desc
    @follower = @user.follower_user.id_desc
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
