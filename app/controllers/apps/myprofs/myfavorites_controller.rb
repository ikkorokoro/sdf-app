class Apps::Myprofs::MyfavoritesController < Apps::Myprofs::ApplicationController
  def show
    @profile = current_user.profile
    @articles = current_user.favorite_articles
  end
  end