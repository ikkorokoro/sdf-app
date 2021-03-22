class Apps::Otherusers::UnfollowsController < Apps::Otherusers::ApplicationController

  def create
    user = User.find(params[:account_id])
    current_user.unfollow!(user)
    follower = user.followers.count
    render json: {status: 'ok', follower: follower}
  end
end
