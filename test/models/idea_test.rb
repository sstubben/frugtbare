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

  should validate_presence_of(:description)
  should validate_numericality_of(:level_of_fun).only_integer
  should validate_numericality_of(:level_of_complexity).only_integer
  should validate_numericality_of(:level_of_fun)
    .is_greater_than_or_equal_to(0)
    .is_less_than_or_equal_to(5)
  should validate_numericality_of(:level_of_complexity)
    .is_greater_than_or_equal_to(0)
    .is_less_than_or_equal_to(5)
end
