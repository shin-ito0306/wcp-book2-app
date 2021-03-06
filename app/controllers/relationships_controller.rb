class RelationshipsController < ApplicationController
  def create
    follow = current_user.follower_do.build(followed_id: params[:user_id])
    follow.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    follow = current_user.follower_do.find_by(followed_id: params[:user_id])
    follow.destroy
    redirect_back(fallback_location: root_path)
  end
end
