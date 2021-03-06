# frozen_string_literal: true

require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  def setup
    @user = users(:user)
    @one = ideas(:one)
    @two = ideas(:two)
    @three = ideas(:three)
    @four = ideas(:four)
  end

  test 'valid idea' do
    assert @one.valid?
  end

  test 'invalid idea' do
    assert_not @four.valid?
  end

  test 'user association' do
    assert_equal @user, @one.user
  end

  # validators
  should validate_presence_of(:description)
  should validate_numericality_of(:level_of_fun).only_integer
  should validate_numericality_of(:level_of_complexity).only_integer
  should validate_numericality_of(:level_of_fun)
    .is_greater_than_or_equal_to(0)
    .is_less_than_or_equal_to(5)
  should validate_numericality_of(:level_of_complexity)
    .is_greater_than_or_equal_to(0)
    .is_less_than_or_equal_to(5)

  # methods
  test '#rating' do
    assert_equal 0, @one.rating
    assert_equal(-4, @three.rating)
  end

  # scopes
  test '#created_today' do
    assert_includes Idea.created_today, ideas(:one)
    assert_equal 2, Idea.created_today.size
    refute_includes Idea.created_today, ideas(:three)
  end
end
