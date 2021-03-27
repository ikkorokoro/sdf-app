class Api::InformationsController < Api::ApplicationController

  def index
    user = User.find(params[:account_id])
    has_followed = current_user.has_followed?(user)
    followers_count = user.followers.count
    followings_count = user.followings.count
    render json: { hasFollow: has_followed, followersCount: followers_count, followingsCount: followings_count }
  end
end
