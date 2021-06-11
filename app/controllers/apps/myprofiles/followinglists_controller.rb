class Apps::Myprofiles::FollowinglistsController < Apps::Myprofiles::ApplicationController

  def show
    @users = current_user.followings.includes(profile: [avatar_attachment: :blob])
  end
end