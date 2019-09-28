require 'test_helper'

class WorkspaceUsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @workspace_user = workspace_users(:one)
  end

  test "should get index" do
    get workspace_users_url
    assert_response :success
  end

  test "should get new" do
    get new_workspace_user_url
    assert_response :success
  end

  test "should create workspace_user" do
    assert_difference('WorkspaceUser.count') do
      post workspace_users_url, params: { workspace_user: { user_id: @workspace_user.user_id, workspace_id: @workspace_user.workspace_id } }
    end

    assert_redirected_to workspace_user_url(WorkspaceUser.last)
  end

  test "should show workspace_user" do
    get workspace_user_url(@workspace_user)
    assert_response :success
  end

  test "should get edit" do
    get edit_workspace_user_url(@workspace_user)
    assert_response :success
  end

  test "should update workspace_user" do
    patch workspace_user_url(@workspace_user), params: { workspace_user: { user_id: @workspace_user.user_id, workspace_id: @workspace_user.workspace_id } }
    assert_redirected_to workspace_user_url(@workspace_user)
  end

  test "should destroy workspace_user" do
    assert_difference('WorkspaceUser.count', -1) do
      delete workspace_user_url(@workspace_user)
    end

    assert_redirected_to workspace_users_url
  end
end
