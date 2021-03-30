FactoryBot.define do
  factory :article do
    object { '物品' }
    price { 3000 }
    store { '店' }
    content { Faker::Lorem.characters(number: 50) }
    rate { 1 }
  end
end
