# == Schema Information
#
# Table name: categories
#
#  id            :bigint           not null, primary key
#  category_name :string(255)      not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Category < ApplicationRecord
  has_many :articles
  validates :category_name, presence: true
end
