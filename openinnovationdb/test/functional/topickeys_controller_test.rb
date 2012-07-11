require 'test_helper'

class TopickeysControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get statistics" do
    get :statistics
    assert_response :success
  end

end
