# frozen_string_literal: true

module UserDecorator
  def avatar_image
    if profile&.avatar&.attached?#画像がアップロードされているかのメソッド
      profile.avatar
    end
  end

  def display_name
    profile&.name || account
  end

  def if_affiliation
    profile&.affiliation
  end

  def if_intro
    profile&.introduction
  end

  def follow_count
    followings.count
  end

  def follower_count
    followers.count
  end
end
