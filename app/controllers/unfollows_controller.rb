class UnfollowsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def create
    user = User.find(params[:account_id])
    current_user.unfollow!(user)
    follower = user.followers.count
    render json: {status: 'ok', follower: follower}
  end
end