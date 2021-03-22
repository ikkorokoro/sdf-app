class Apps::Otherusers::OthertimelinesController < Apps::Otherusers::ApplicationController

  def show
    @user = User.find(params[:account_id])
    @profile = @user.profile
    user_ids = current_user.followings.pluck(:id)#フォローしているユーザーのidのみを取得
    @articles = Article.with_attached_image.includes(:tags, user: [profile: [avatar_attachment: :blob]]).where(user_id: user_ids)#フォローしているユーザーの投稿を4つ取得
  end
  end
