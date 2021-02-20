# frozen_string_literal: true

require 'test_helper'

class NotificationDecoratorTest < ActiveSupport::TestCase
  def setup
    @notification = Notification.new.extend NotificationDecorator
  end

  # test "the truth" do
  #   assert true
  # end
end
