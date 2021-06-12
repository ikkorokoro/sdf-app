class Apps::Myprofiles::NotificationsController < Apps::Myprofiles::ApplicationController

  def show
    @profile = current_user.profile
    @articles = current_user.articles.with_attached_image.includes(:tags)
    @notifications = current_user.passive_notifications.includes(:visiter, :visited, :article)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    @notifications = @notifications.where.not(visiter_id: current_user.id)
  end
end