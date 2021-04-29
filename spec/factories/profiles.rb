# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  affiliation :string(191)
#  name        :string(191)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
FactoryBot.define do
  factory :profile do

  end
end
