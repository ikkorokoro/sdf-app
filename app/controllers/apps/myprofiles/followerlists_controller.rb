class Apps::Myprofiles::FollowerlistsController < Apps::Myprofiles::ApplicationController

  def show
    @users = current_user.followers.includes(profile: [avatar_attachment: :blob])
  end
end
