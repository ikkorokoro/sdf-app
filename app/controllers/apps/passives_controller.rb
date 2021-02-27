class Apps::PassivesController < Apps::ApplicationController

  def index
    @user = User.find(params[:account_id])
    @users = @user.followers
  end
end
