class Apps::OtherUsers::OtherarticlesController < Apps::OtherUsers::ApplicationController

  def show
    @user = User.find(params[:account_id])
    @articles = @user.articles.with_attached_image.includes(:tags)
  end
end