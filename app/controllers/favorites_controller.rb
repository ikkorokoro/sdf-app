class FavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    @user = User.find(params[:account_id])
    @profile = @user.profile
    @articles = @user.favorite_articles
  end
  end