class Article < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  validates :object, presence: true, length: { maximum: 10 }
  validates :price, presence: true, length: { maximum: 6 }
  validates :store, presence: true, length: { maximum: 10 }
  validates :category, presence: true
  validates :content, presence: true, length: { maximum: 100 }
end
