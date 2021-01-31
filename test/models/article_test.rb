# == Schema Information
#
# Table name: articles
#
#  id          :bigint           not null, primary key
#  category    :string(255)      not null
#  content     :string(255)      not null
#  object      :string(255)      not null
#  price       :integer          not null
#  rate        :integer
#  store       :string(255)      not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_articles_on_category_id  (category_id)
#  index_articles_on_user_id      (user_id)
#
require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
