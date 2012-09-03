require 'test_helper'

class TopickeysControllerTest < ActionController::TestCase
  setup do
    @topickey = topickeys(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:topickeys)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create topickey" do
    assert_difference('Topickey.count') do
      post :create, topickey: { freq: @topickey.freq, name: @topickey.name, topic_id: @topickey.topic_id, urlkey: @topickey.urlkey }
    end

    assert_redirected_to topickey_path(assigns(:topickey))
  end

  test "should show topickey" do
    get :show, id: @topickey
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @topickey
    assert_response :success
  end

  test "should update topickey" do
    put :update, id: @topickey, topickey: { freq: @topickey.freq, name: @topickey.name, topic_id: @topickey.topic_id, urlkey: @topickey.urlkey }
    assert_redirected_to topickey_path(assigns(:topickey))
  end

  test "should destroy topickey" do
    assert_difference('Topickey.count', -1) do
      delete :destroy, id: @topickey
    end

    assert_redirected_to topickeys_path
  end
end
