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
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :account, presence: true
  # VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    # format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
  has_many :articles, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :favorite_articles, through: :likes, source: :article
  has_many :following_relationships, foreign_key: 'follower_id', class_name: 'Relationship', dependent: :destroy
  has_many :followings, through: :following_relationships, source: :following
  has_many :follower_relationships, foreign_key: 'following_id', class_name: 'Relationship', dependent: :destroy
  has_many :followers, through: :follower_relationships, source: :follower
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visiter_id', dependent: :destroy
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy
  has_one :profile, dependent: :destroy

  before_create :default_avatar
  def default_avatar
    profile = self.build_profile
    profile.avatar.attach(io: File.open(Rails.root.join('app', 'assets', 'images', '1954451.jpg')), filename: '1954451.jpg', content_type: 'image/png')
  end

  def has_written?(article)
    articles.exists?(id: article.id)
  end

  def has_liked?(article)
    likes.exists?(article_id: article.id)
  end

  def follow!(user)
    user_id = get_user_id(user)
    following_relationships.create!(following_id: user_id)
  end

  def unfollow!(user)
    user_id = get_user_id(user)
    relation = following_relationships.find_by!(following_id: user_id)
    relation.destroy!
  end

  def has_followed?(user)
    following_relationships.exists?(following_id: user.id)
  end

  def prepre_profile
    profile || build_profile
  end

  def create_notification_follow!(current_user)
    temp = Notification.where(['visiter_id = ? and visited_id = ? and action = ? ',current_user.id, id, 'follow'])
    if temp.blank?
      notification = current_user.active_notifications.new(
        visited_id: id,
        action: 'follow'
      )
      notification.save if notification.valid?
    end
  end

  def self.guest
    find_or_create_by!(account: 'aiueokaki', email: 'guest@example.com') do |user|
    user.password = SecureRandom.urlsafe_base64
  end
end

  private
    def get_user_id(user)
      if user.is_a?(User)
        user.id
      else
        user
      end
    end
  end
