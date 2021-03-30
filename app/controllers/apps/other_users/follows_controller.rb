class Apps::OtherUsers::FollowsController < Apps::OtherUsers::ApplicationController

  def create
    user = User.find(params[:account_id])
    current_user.follow!(user)
    #通知の作成
    user.create_notification_follow!(current_user)
    follower_count = user.followers.count
    render json: {status: 'ok', followerCount: follower_count}
  end
end
