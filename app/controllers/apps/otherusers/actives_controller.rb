class Apps::Otherusers::ActivesController < Apps::Otherusers::ApplicationController

  def index
    @user = User.find(params[:account_id])
    @users = @user.followings.includes(profile: [avatar_attachment: :blob])
  end
end
