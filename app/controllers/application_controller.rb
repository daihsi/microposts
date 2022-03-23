class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
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
      @current_user ||= User.find_by(uid: session[:uid])
    end
  end

  def log_out
    @current_user = nil
  end

  helper_method :current_user
end