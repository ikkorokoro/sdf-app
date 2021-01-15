# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  category   :string(255)      not null
#  content    :string(255)      not null
#  object     :string(255)      not null
#  price      :integer          not null
#  store      :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :commnets, dependet: :destroy
  validates :object, presence: true, length: { maximum: 10 }
  validates :price, presence: true, length: { maximum: 6 }
  validates :store, presence: true, length: { maximum: 10 }
  validates :category, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
