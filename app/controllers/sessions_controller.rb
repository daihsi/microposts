class SessionsController < ApplicationController
  before_action :already_login?, except: :destroy
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:uid] = user.uid
      session[:id] = user.id
      redirect_to posts_path
    else
      render :new
    end
  end

  def destroy
    session[:uid] = nil
    session[:id] = nil
    redirect_to root_path
  end
end