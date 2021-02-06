class TimelinesController < ApplicationController
  before_action :authenticate_user!, only: [:show]
  def show
    user_ids = current_user.followings.pluck(:id)#フォローしているユーザーのidのみを取得
    @articles = Article.where(user_id: user_ids)#フォローしているユーザーの投稿を4つ取得
  end
  end