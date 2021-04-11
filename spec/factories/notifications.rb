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