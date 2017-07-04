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

=begin
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
=end

end
