class FollowsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    Follow.create(user_id: params[:user_id], following_id: params[:following_id])
    #update follower count
    follower = User.find(params[:following_id])
    current_follower_count = follower.follower_count
    follower.update(follower_count: current_follower_count + 1)

    redirect_to user_path(params[:following_id])
  end

  def destroy
    #calls .first in order to get a single entry. The where call only returns one follow
    @follow = Follow.where(user_id: params[:user_id], following_id: params[:following_id]).first
    #update follower count
    follower = User.find(params[:following_id])
    current_follower_count = follower.follower_count
    follower.update(follower_count: current_follower_count - 1)

    @follow.destroy
    redirect_to user_path(params[:following_id])
  end
end
