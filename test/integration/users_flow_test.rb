require 'test_helper'
include IntegrationMacros

class UsersFlowTest < Capybara::Rails::TestCase
  def setup
    @user = users :user
    @admin = users :admin
  end

  def teardown
    logout_with_warden!
  end

  test 'users index' do
    login_with_warden(@admin)
    visit users_path

    assert page.has_content?(@admin.email)
    assert page.has_content?(@user.email)
  end

  test 'user show' do
    login_with_warden(@admin)
    visit user_path(@user.id)

    assert page.has_content?(@user.email)
  end
end
