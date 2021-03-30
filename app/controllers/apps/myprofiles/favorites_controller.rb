class Apps::Myprofiles::FavoritesController < Apps::Myprofiles::ApplicationController

  def show
    @profile = current_user.profile
    @articles = current_user.favorite_articles.with_attached_image.includes(:tags, user: [profile: [avatar_attachment: :blob]])
  end
end
