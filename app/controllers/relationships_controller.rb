class RelationshipsController < ApplicationController
  def create
    current_user.follow(user_id: params[:user_id])
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(user_id: params[:user_id])
    redirect_to request.referer
  end
end
