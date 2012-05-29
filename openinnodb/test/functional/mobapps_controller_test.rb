require 'test_helper'

class MobappsControllerTest < ActionController::TestCase
  setup do
    @mobapp = mobapps(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mobapps)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mobapp" do
    assert_difference('Mobapp.count') do
      post :create, mobapp: { appic: @mobapp.appic, category: @mobapp.category, commissioner: @mobapp.commissioner, copyright: @mobapp.copyright, creator: @mobapp.creator, date: @mobapp.date, devlanguage: @mobapp.devlanguage, downloads: @mobapp.downloads, free: @mobapp.free, hardware: @mobapp.hardware, location: @mobapp.location, name: @mobapp.name, novel: @mobapp.novel, paid: @mobapp.paid, platform: @mobapp.platform, rating: @mobapp.rating, repackaged: @mobapp.repackaged, returnusers: @mobapp.returnusers, updated: @mobapp.updated }
    end

    assert_redirected_to mobapp_path(assigns(:mobapp))
  end

  test "should show mobapp" do
    get :show, id: @mobapp
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @mobapp
    assert_response :success
  end

  test "should update mobapp" do
    put :update, id: @mobapp, mobapp: { appic: @mobapp.appic, category: @mobapp.category, commissioner: @mobapp.commissioner, copyright: @mobapp.copyright, creator: @mobapp.creator, date: @mobapp.date, devlanguage: @mobapp.devlanguage, downloads: @mobapp.downloads, free: @mobapp.free, hardware: @mobapp.hardware, location: @mobapp.location, name: @mobapp.name, novel: @mobapp.novel, paid: @mobapp.paid, platform: @mobapp.platform, rating: @mobapp.rating, repackaged: @mobapp.repackaged, returnusers: @mobapp.returnusers, updated: @mobapp.updated }
    assert_redirected_to mobapp_path(assigns(:mobapp))
  end

  test "should destroy mobapp" do
    assert_difference('Mobapp.count', -1) do
      delete :destroy, id: @mobapp
    end

    assert_redirected_to mobapps_path
  end
end
