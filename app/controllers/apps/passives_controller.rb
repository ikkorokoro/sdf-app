class Apps::PassivesController < Apps::ApplicationController

  def index
    @user = User.find(params[:account_id])
    @users = @user.followers.includes(profile: [avatar_attachment: :blob])
  end
end
