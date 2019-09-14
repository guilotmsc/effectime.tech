require 'test_helper'

class CorporationUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @corporation_user = corporation_users(:one)
  end

  test "should get index" do
    get corporation_users_url
    assert_response :success
  end

  test "should get new" do
    get new_corporation_user_url
    assert_response :success
  end

  test "should create corporation_user" do
    assert_difference('CorporationUser.count') do
      post corporation_users_url, params: { corporation_user: { corporation_id: @corporation_user.corporation_id, user_id: @corporation_user.user_id } }
    end

    assert_redirected_to corporation_user_url(CorporationUser.last)
  end

  test "should show corporation_user" do
    get corporation_user_url(@corporation_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_corporation_user_url(@corporation_user)
    assert_response :success
  end

  test "should update corporation_user" do
    patch corporation_user_url(@corporation_user), params: { corporation_user: { corporation_id: @corporation_user.corporation_id, user_id: @corporation_user.user_id } }
    assert_redirected_to corporation_user_url(@corporation_user)
  end

  test "should destroy corporation_user" do
    assert_difference('CorporationUser.count', -1) do
      delete corporation_user_url(@corporation_user)
    end

    assert_redirected_to corporation_users_url
  end
end
