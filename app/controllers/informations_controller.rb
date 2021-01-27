class InformationsController < ApplicationController
  before_action :authenticate_user!, only: [:index]

  def index
    user = User.find(params[:account_id])
    has_status = current_user.has_followed?(user)
    followers = user.followers.count
    followings = user.followings.count
    render json: {hasFollow: has_status, followers: followers, followings: followings }
  end
end