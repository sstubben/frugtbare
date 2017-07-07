# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'Tweeter instance' do
    @tweeter = Tweeter.new(@user)
    assert_instance_of Tweeter, @tweeter
    assert_equal @user.id, @tweeter.user.id
  end
end
