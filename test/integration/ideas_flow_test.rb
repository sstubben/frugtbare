require 'test_helper'
include IntegrationMacros

class IdeasFlowTest < Capybara::Rails::TestCase
  def setup
    @one = ideas :one
    @two = ideas :two
    @user = users :user
    login_with_warden(@user)
  end

  def teardown
    logout_with_warden!
  end

  test 'idea index' do
    visit ideas_path

    assert page.has_content?(@one.description)
    assert page.has_content?(@two.description)
  end
end
