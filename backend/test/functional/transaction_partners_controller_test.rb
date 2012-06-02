require 'test_helper'

class TransactionPartnersControllerTest < ActionController::TestCase
  setup do
    @transaction_partner = transaction_partners(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transaction_partners)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction_partner" do
    assert_difference('TransactionPartner.count') do
      post :create, transaction_partner: { account_holder: @transaction_partner.account_holder, bank_name: @transaction_partner.bank_name }
    end

    assert_redirected_to transaction_partner_path(assigns(:transaction_partner))
  end

  test "should show transaction_partner" do
    get :show, id: @transaction_partner
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transaction_partner
    assert_response :success
  end

  test "should update transaction_partner" do
    put :update, id: @transaction_partner, transaction_partner: { account_holder: @transaction_partner.account_holder, bank_name: @transaction_partner.bank_name }
    assert_redirected_to transaction_partner_path(assigns(:transaction_partner))
  end

  test "should destroy transaction_partner" do
    assert_difference('TransactionPartner.count', -1) do
      delete :destroy, id: @transaction_partner
    end

    assert_redirected_to transaction_partners_path
  end
end
