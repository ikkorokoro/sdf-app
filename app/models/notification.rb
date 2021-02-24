# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  action     :string(191)
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  article_id :integer
#  comment_id :integer
#  visited_id :integer
#  visiter_id :integer
#
class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  belongs_to :article, optional: true
  belongs_to :comment, optional: true

  belongs_to :visiter, class_name: 'User', foreign_key: 'visiter_id', optional: true
  belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
