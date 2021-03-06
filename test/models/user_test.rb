# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
    @admin = users(:admin)
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid without email' do
    @user.email = ''
    assert_not_nil @user.errors[:email]
    assert_not @user.valid?
  end

  test 'invalid without password' do
    @user.password = ''
    assert_not_nil @user.errors[:password]
    assert_not @user.valid?
  end

  test 'admin default to false' do
    assert @user.admin == false
  end

  test 'ideas association' do
    assert_equal 3, @user.ideas.size
  end

  # validators
  should validate_presence_of(:email)
  should validate_presence_of(:encrypted_password)

  # methods
  test '#number_of_ideas_created_today' do
    assert_equal 2, @user.number_of_ideas_created_today
  end

  test '#number_of_total_ideas' do
    assert_equal 3, @user.number_of_total_ideas
    assert_equal 0, @admin.number_of_total_ideas
  end
end
