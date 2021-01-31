# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  content     :string(255)      not null
#  object      :string(255)      not null
#  price       :integer          not null
#  rate        :integer
#  store       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer          not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_category_id  (category_id)
#  index_articles_on_user_id      (user_id)
#
class Article < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :category, dependent: :destroy
  validates :object, presence: true, length: { maximum: 10 }
  validates :price, presence: true, length: { maximum: 6 }
  validates :store, presence: true, length: { maximum: 10 }
  validates :category, presence: true
  validates :rate, presence: true
  validates :content, presence: true, length: { maximum: 100 }
  validate :image_presence
  def image_presence
    if image.attached?
      if !image.content_type.in?(%('image/jpeg image/png'))
        errors.add(:image, 'にはjpegまたはpngファイルを添付してください')
      end
    else
      errors.add(:image, 'ファイルを添付してください')
    end
  end
end
