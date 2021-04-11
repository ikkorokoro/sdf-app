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
FactoryBot.define do
  factory :article do
    object { '物品' }
    price { 3000 }
    store { '店' }
    content { 'ありがとう'}
    rate { 1 }
    association :user
    association :category

    after(:build) do |article|
      article.image.attach(io: File.open('app/assets/images/danntaio-01.jpg'), filename: 'danntaio-01.jpg', content_type: 'image/jpg')
    end
  end
end
