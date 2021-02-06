class OthertimelinesController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
    @user = User.find(params[:account_id])
    @profile = @user.profile
    user_ids = current_user.followings.pluck(:id)#フォローしているユーザーのidのみを取得
    @articles = Article.where(user_id: user_ids)#フォローしているユーザーの投稿を4つ取得
  end
  end