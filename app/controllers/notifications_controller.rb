class NotificationsController < ApplicationController
  
  def index
    @notifications = current_user.passive_notifications.includes(:visiter, :visited, :article)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
  end
end
