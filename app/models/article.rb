# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  content     :string(191)      not null
#  object      :string(191)      not null
#  price       :integer          not null
#  rate        :integer
#  store       :string(191)      not null
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
  has_many :article_tags, dependent: :destroy
  has_many :tags, through: :article_tags
  has_many :notifications, dependent: :destroy
  belongs_to :category, dependent: :destroy
  validates :object, presence: true, length: { maximum: 10 }
  validates :price, presence: true, length: { maximum: 6 }
  validates :store, presence: true, length: { maximum: 10 }
  validates :category_id, presence: true
  validates :rate, presence: true
  validates :content, presence: true, length: { maximum: 100 }

  def create_notification_like!(current_user)
    # すでに「いいね」されているか検索
    temp = Notification.where(['visiter_id = ? and visited_id = ? and article_id = ? and action = ? ', current_user.id, user_id, id, 'like'])
    # いいねされていない場合のみ、通知レコードを作成
    if temp.blank?
      notification = current_user.active_notifications.new(
        article_id: id,
        visited_id: user_id,
        action: 'like'
      )
      # 自分の投稿に対するいいねの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end
    def create_notification_comment!(current_user, comment_id)
      # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
      temp_ids = Comment.select(:user_id).where(article_id: id).where.not(user_id: current_user.id).distinct
      temp_ids.each do |temp_id|
        save_notification_comment!(current_user, comment_id, temp_id['user_id'])
      end
      # まだ誰もコメントしていない場合は、投稿者に通知を送る
      save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
    end

    def save_notification_comment!(current_user, comment_id, visited_id)
      # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
      notification = current_user.active_notifications.new(
        article_id: id,
        comment_id: comment_id,
        visited_id: visited_id,
        action: 'comment'
      )
      # 自分の投稿に対するコメントの場合は、通知済みとする
      if notification.visiter_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  # validate :image_presence
  # def image_presence
  #   if image.attached?
  #     if !image.content_type.in?(%('image/jpeg image/png'))
  #       errors.add(:image, 'にはjpegまたはpngファイルを添付してください')
  #     end
  #   else
  #     errors.add(:image, 'ファイルを添付してください')
  #   end
  # end
end
