require 'test_helper'

class CorporationTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @corporation_type = corporation_types(:one)
  end

  test "should get index" do
    get corporation_types_url
    assert_response :success
  end

  test "should get new" do
    get new_corporation_type_url
    assert_response :success
  end

  test "should create corporation_type" do
    assert_difference('CorporationType.count') do
      post corporation_types_url, params: { corporation_type: { name: @corporation_type.name } }
    end

    assert_redirected_to corporation_type_url(CorporationType.last)
  end

  test "should show corporation_type" do
    get corporation_type_url(@corporation_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_corporation_type_url(@corporation_type)
    assert_response :success
  end

  test "should update corporation_type" do
    patch corporation_type_url(@corporation_type), params: { corporation_type: { name: @corporation_type.name } }
    assert_redirected_to corporation_type_url(@corporation_type)
  end

  test "should destroy corporation_type" do
    assert_difference('CorporationType.count', -1) do
      delete corporation_type_url(@corporation_type)
    end

    assert_redirected_to corporation_types_url
  end
end
