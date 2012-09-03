require 'test_helper'

class GitusersControllerTest < ActionController::TestCase
  setup do
    @gituser = gitusers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gitusers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gituser" do
    assert_difference('Gituser.count') do
      post :create, gituser: { company: @gituser.company, email: @gituser.email, followers: @gituser.followers, language: @gituser.language, location: @gituser.location, member_since: @gituser.member_since, name: @gituser.name, personal_url: @gituser.personal_url, projects: @gituser.projects, repos: @gituser.repos, url: @gituser.url, username: @gituser.username }
    end

    assert_redirected_to gituser_path(assigns(:gituser))
  end

  test "should show gituser" do
    get :show, id: @gituser
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gituser
    assert_response :success
  end

  test "should update gituser" do
    put :update, id: @gituser, gituser: { company: @gituser.company, email: @gituser.email, followers: @gituser.followers, language: @gituser.language, location: @gituser.location, member_since: @gituser.member_since, name: @gituser.name, personal_url: @gituser.personal_url, projects: @gituser.projects, repos: @gituser.repos, url: @gituser.url, username: @gituser.username }
    assert_redirected_to gituser_path(assigns(:gituser))
  end

  test "should destroy gituser" do
    assert_difference('Gituser.count', -1) do
      delete :destroy, id: @gituser
    end

    assert_redirected_to gitusers_path
  end
end
