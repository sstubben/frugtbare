# frozen_string_literal: true

require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @admin = users(:admin)
    @user = users(:user)
  end

  test 'should get index when admin' do
    sign_in @admin
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test 'should redirect to root on get index when user' do
    sign_in @user
    get :index
    assert_redirected_to root_path
  end

  test 'should show user' do
    sign_in @user
    get :show, id: @user
    assert_response :success
  end
end
