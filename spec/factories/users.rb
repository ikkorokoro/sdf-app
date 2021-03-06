# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  account                :string(191)      default(""), not null
#  email                  :string(191)      default(""), not null
#  encrypted_password     :string(191)      default(""), not null
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(191)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'password' }
    account {'ikikikik'}
    trait :with_profile do
      after :build do |user|
        create(:profile, user: user)
      end
    end
  end
end
