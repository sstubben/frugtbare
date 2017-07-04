require 'test_helper'

class IdeasControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @idea = ideas(:one)
    @user = users(:user)
    sign_in @user
  end

  def teardown
    sign_out @user
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ideas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create idea" do
    assert_difference('Idea.count') do
      post :create, idea: { description: @idea.description, level_of_complexity: @idea.level_of_complexity, level_of_fun: @idea.level_of_fun }
    end

    assert_redirected_to idea_path(assigns(:idea))
  end

  test "should show idea" do
    get :show, id: @idea
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @idea
    assert_response :success
  end

  test "should update idea" do
    patch :update, id: @idea, idea: { description: @idea.description, level_of_complexity: @idea.level_of_complexity, level_of_fun: @idea.level_of_fun }
    assert_redirected_to idea_path(assigns(:idea))
  end

  test "should destroy idea" do
    assert_difference('Idea.count', -1) do
      delete :destroy, id: @idea
    end

    assert_redirected_to ideas_path
  end
end
