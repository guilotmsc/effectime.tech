require 'test_helper'

class ProcessDeptsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @process_dept = process_depts(:one)
  end

  test "should get index" do
    get process_depts_url
    assert_response :success
  end

  test "should get new" do
    get new_process_dept_url
    assert_response :success
  end

  test "should create process_dept" do
    assert_difference('ProcessDept.count') do
      post process_depts_url, params: { process_dept: { area_id: @process_dept.area_id, name: @process_dept.name } }
    end

    assert_redirected_to process_dept_url(ProcessDept.last)
  end

  test "should show process_dept" do
    get process_dept_url(@process_dept)
    assert_response :success
  end

  test "should get edit" do
    get edit_process_dept_url(@process_dept)
    assert_response :success
  end

  test "should update process_dept" do
    patch process_dept_url(@process_dept), params: { process_dept: { area_id: @process_dept.area_id, name: @process_dept.name } }
    assert_redirected_to process_dept_url(@process_dept)
  end

  test "should destroy process_dept" do
    assert_difference('ProcessDept.count', -1) do
      delete process_dept_url(@process_dept)
    end

    assert_redirected_to process_depts_url
  end
end
