# frozen_string_literal: true

module UserDecorator
  def avatar_image
    if profile&.avatar&.attached?#画像がアップロードされているかのメソッド
      profile.avatar
    else
      '軍人のアイコン素材.png'
    end
  end

  def display_name
    profile&.name || account
  end
end
