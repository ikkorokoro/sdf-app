# == Schema Information
#
# Table name: profiles
#
#  id          :bigint           not null, primary key
#  affiliation :string(255)
#  name        :string(255)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_profiles_on_user_id  (user_id)
#
class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  has_rich_text :introduction

  validates :name, presence: true
  validates :affiliation, presence: true
end
