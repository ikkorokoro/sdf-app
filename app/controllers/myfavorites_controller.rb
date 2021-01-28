class MyfavoritesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    @profile = current_user.profile
    @articles = current_user.favorite_articles
  end
  end