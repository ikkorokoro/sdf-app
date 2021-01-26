class CommentSerializer < ActiveModel::Serializer
include Rails.application.routes.url_helpers
  attributes :id, :content, :avatar_url, :display_name
  belongs_to :user
  def avatar_url
    rails_blob_path(object.user.profile.avatar) if object.user.profile.avatar.attached?
  end

  def display_name
    if object.user&.profile && object.user&.profile&.name
      object.user.profile.name
    else
      object.user.account
    end
  end
end
