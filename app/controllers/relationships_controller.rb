class RelationshipsController < ApplicationController
  def create
    user = User.find(params[:user_id])
    following = Relationship.new(following_id: current_user.id, follower_id: user.id)
    following.save
    redirect_back(fallback_location: root_path)
  end

  def destroy
    user = User.find(params[:user_id])
    follower = Relationship.find_by(following_id: current_user.id, follower_id: user.id)
    follower.destroy
    redirect_back(fallback_location: root_path)
  end
end

# Relationship.where(followings_id: user )とuser.followingsは同じ意味
