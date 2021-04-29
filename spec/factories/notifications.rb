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
FactoryBot.define do
  factory :notification do
    action {'like'}
    checked {false}
    article_id {nil}
    comment_id {nil}
    visited_id {nil}
    visiter_id {nil}
    association :comment
    association :article
    association :visiter
    association :visited
  end
end
