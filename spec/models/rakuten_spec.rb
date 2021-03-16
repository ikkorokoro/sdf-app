# == Schema Information
#
# Table name: rakutens
#
#  id             :bigint           not null, primary key
#  image_urls     :string(191)
#  item_name      :string(191)
#  item_price     :integer
#  item_url       :string(191)
#  review_average :integer
#  shop_name      :string(191)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  genle_id       :string(191)
#
require 'rails_helper'

RSpec.describe Rakuten, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
