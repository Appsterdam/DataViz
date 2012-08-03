require 'test_helper'

class LnkdinsControllerTest < ActionController::TestCase
  setup do
    @lnkdin = lnkdins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lnkdins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lnkdin" do
    assert_difference('Lnkdin.count') do
      post :create, lnkdin: { first_name: @lnkdin.first_name, last_name: @lnkdin.last_name, positions: @lnkdin.positions }
    end

    assert_redirected_to lnkdin_path(assigns(:lnkdin))
  end

  test "should show lnkdin" do
    get :show, id: @lnkdin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lnkdin
    assert_response :success
  end

  test "should update lnkdin" do
    put :update, id: @lnkdin, lnkdin: { first_name: @lnkdin.first_name, last_name: @lnkdin.last_name, positions: @lnkdin.positions }
    assert_redirected_to lnkdin_path(assigns(:lnkdin))
  end

  test "should destroy lnkdin" do
    assert_difference('Lnkdin.count', -1) do
      delete :destroy, id: @lnkdin
    end

    assert_redirected_to lnkdins_path
  end
end
