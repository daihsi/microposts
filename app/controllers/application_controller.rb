class ApplicationController < ActionController::Base
  def login?
    if current_user.nil?
      redirect_to login_path
    end
  end

  def already_login?
    unless current_user.nil?
      redirect_to posts_path
    end
  end

  def current_user
    if session[:uid]
      user ||= User.find_by(session[:uid])
    end
  end
end