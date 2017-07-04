require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user = users(:user)
    sign_in @user
  end

  def teardown
    sign_out @user
  end

  test 'should get index' do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test 'should show user' do
    get :show, id: @user
    assert_response :success
  end

  test 'should get edit' do
    get :edit, id: @user
    assert_response :success
  end

  test 'should update user' do
    patch :update, id: @user, user: { email: @user.email }
    assert_redirected_to user_path(assigns(:user))
  end

  test 'should destroy user' do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end