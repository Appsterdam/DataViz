require 'test_helper'

class ImportcentralControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
