# == Schema Information
#
# Table name: buylists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rakuten_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_buylists_on_rakuten_id  (rakuten_id)
#  index_buylists_on_user_id     (user_id)
#
FactoryBot.define do
  factory :buylist do

  end
end
