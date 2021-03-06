# == Schema Information
#
# Table name: tags
#
#  id         :bigint           not null, primary key
#  name       :string(191)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Tag < ApplicationRecord
  has_many :article_tags, dependent: :destroy
  has_many :article, through: :article_tags
end
