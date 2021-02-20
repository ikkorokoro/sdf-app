# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  content    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :bigint           not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_comments_on_article_id  (article_id)
#  index_comments_on_user_id     (user_id)
#
class CommentSerializer < ActiveModel::Serializer
include Rails.application.routes.url_helpers
  attributes :id, :content, :avatar_url, :display_name, :created_at
  belongs_to :user
  def avatar_url
      rails_blob_path(object.user.profile.avatar)
  end

  def display_name
    if object.user&.profile && object.user&.profile&.name
      object.user.profile.name
    else
      object.user.account
    end
  end
end
