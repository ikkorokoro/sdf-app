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
require 'rails_helper'

RSpec.describe Article, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
