class Apps::Myprofiles::TimelinesController < Apps::Myprofiles::ApplicationController

  def show
    user_ids = current_user.followings.pluck(:id)#フォローしているユーザーのidのみを取得
    @articles = Article.with_attached_image.includes(:category, :tags, user: [profile: [avatar_attachment: :blob]]).where(user_id: user_ids)#フォローしているユーザーの投稿を取得
  end
end
