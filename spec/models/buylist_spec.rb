# == Schema Information
#
# Table name: buylists
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  rakuten_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_buylists_on_rakuten_id  (rakuten_id)
#  index_buylists_on_user_id     (user_id)
#
require 'rails_helper'

RSpec.describe Buylist, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
