# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(191)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :tag do
    name { '訓練' }
  end
end
