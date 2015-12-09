require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test "that idea is not empty" do
    idea = Idea.new
    assert idea.invalid?
    assert idea.errors[:description].any?
    assert idea.errors[:level_of_fun].any?
    assert idea.errors[:level_of_complexity].any?
  end

  test "that idea has a many to one relation with User" do
    
  end

end
