class Apps::Myprofs::TimelinesController < Apps::Myprofs::ApplicationController
  
  def show
    user_ids = current_user.followings.pluck(:id)#フォローしているユーザーのidのみを取得
    @articles = Article.where(user_id: user_ids)#フォローしているユーザーの投稿を4つ取得
  end
  end