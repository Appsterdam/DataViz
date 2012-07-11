require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  setup do
    @member = members(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post :create, member: { bio: @member.bio, city: @member.city, country: @member.country, email: @member.email, joined: @member.joined, lang: @member.lang, lat: @member.lat, link: @member.link, lon: @member.lon, meetup_id: @member.meetup_id, name: @member.name, photo: @member.photo, state: @member.state, visited: @member.visited }
    end

    assert_redirected_to member_path(assigns(:member))
  end

  test "should show member" do
    get :show, id: @member
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @member
    assert_response :success
  end

  test "should update member" do
    put :update, id: @member, member: { bio: @member.bio, city: @member.city, country: @member.country, email: @member.email, joined: @member.joined, lang: @member.lang, lat: @member.lat, link: @member.link, lon: @member.lon, meetup_id: @member.meetup_id, name: @member.name, photo: @member.photo, state: @member.state, visited: @member.visited }
    assert_redirected_to member_path(assigns(:member))
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete :destroy, id: @member
    end

    assert_redirected_to members_path
  end
end
