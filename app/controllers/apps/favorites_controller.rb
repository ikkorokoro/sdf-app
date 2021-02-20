class Apps::FavoritesController < Apps::ApplicationController

  def show
    @user = User.find(params[:account_id])
    @profile = @user.profile
    @articles = @user.favorite_articles
  end
  end