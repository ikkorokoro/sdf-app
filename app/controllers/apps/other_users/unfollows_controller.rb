class Apps::OtherUsers::UnfollowsController < Apps::OtherUsers::ApplicationController

  def create
    user = User.find(params[:account_id])
    current_user.unfollow!(user)
    follower_count = user.followers.count
    render json: {status: 'ok', followerCount: follower_count}
  end
end
