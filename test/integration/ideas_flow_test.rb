require 'test_helper'
include IntegrationMacros

class IdeasFlowTest < Capybara::Rails::TestCase
  def setup
    @one = ideas :one
    @two = ideas :two
    @user = users :user
  end

  def teardown
    logout_with_warden!
  end

  test 'idea index' do
    login_with_warden(@user)

    visit ideas_path

    assert page.has_content?(@one.description)
    assert page.has_content?(@two.description)
  end

  test 'idea create - as visitor' do
    visit root_path

    click_link 'Submit Idea!'

    fill_in('Description', with: 'Best Test Idea 1')
    fill_in('Level of fun', with: 4)
    fill_in('Level of complexity', with: 2)

    click_button 'Submit idea'

    assert_current_path idea_path(Idea.last)
    assert page.has_content?('Best Test Idea 1')
  end
end
