# frozen_string_literal: true

require 'test_helper'
include IntegrationMacros
include OmniauthMacros

class UsersFlowTest < Capybara::Rails::TestCase
  def setup
    @user = users :user
    @admin = users :admin
  end

  def teardown
    logout_with_warden!
  end

  test 'existing user login with twitter' do
    visit new_user_session_path

    assert page.has_content?('Sign in with Twitter')
    mock_auth_hash(@user.email)
    click_link 'Sign in'
    assert page.has_content?('Greetings! Let the ideas flow')
    assert page.has_content?(@user.email)
  end

  test 'non-existing user login with twitter' do
    visit new_user_session_path

    assert page.has_content?('Sign in with Twitter')
    mock_auth_hash('non-existing@email.com')
    click_link 'Sign in'
    assert page.has_content?('Sign up')
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
