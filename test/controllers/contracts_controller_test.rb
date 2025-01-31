require 'test_helper'

class ContractsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @contract = contracts(:one)
  end

  test "should get index" do
    get contracts_url
    assert_response :success
  end

  test "should get new" do
    get new_contract_url
    assert_response :success
  end

  test "should create contract" do
    assert_difference('Contract.count') do
      post contracts_url, params: { contract: { amount: @contract.amount, amount_ticket: @contract.amount_ticket, attribuition_model: @contract.attribuition_model, client: @contract.client, date_closing_hours: @contract.date_closing_hours, email: @contract.email, employee_id: @contract.employee_id, hours_volume: @contract.hours_volume, payday: @contract.payday, phone: @contract.phone, signature_date: @contract.signature_date, tolerance: @contract.tolerance, trading_name: @contract.trading_name } }
    end

    assert_redirected_to contract_url(Contract.last)
  end

  test "should show contract" do
    get contract_url(@contract)
    assert_response :success
  end

  test "should get edit" do
    get edit_contract_url(@contract)
    assert_response :success
  end

  test "should update contract" do
    patch contract_url(@contract), params: { contract: { amount: @contract.amount, amount_ticket: @contract.amount_ticket, attribuition_model: @contract.attribuition_model, client: @contract.client, date_closing_hours: @contract.date_closing_hours, email: @contract.email, employee_id: @contract.employee_id, hours_volume: @contract.hours_volume, payday: @contract.payday, phone: @contract.phone, signature_date: @contract.signature_date, tolerance: @contract.tolerance, trading_name: @contract.trading_name } }
    assert_redirected_to contract_url(@contract)
  end

  test "should destroy contract" do
    assert_difference('Contract.count', -1) do
      delete contract_url(@contract)
    end

    assert_redirected_to contracts_url
  end
end
