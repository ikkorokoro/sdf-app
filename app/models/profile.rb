class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar
  has_rich_text :introduction
end
