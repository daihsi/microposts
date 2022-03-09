class SessionsController < ApplicationController
  before_action :already_login?, except: :destroy
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:uid] = user.uid
      redirect_to controller: :users, action: :show, uid: session[:uid]
    else
      render :new
    end
  end

  def destroy
    session[:uid] = nil
    redirect_to root_path
  end
end