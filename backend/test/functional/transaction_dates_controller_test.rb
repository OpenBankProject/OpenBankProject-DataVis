require 'test_helper'

class TransactionDatesControllerTest < ActionController::TestCase
  setup do
    @transaction_date = transaction_dates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:transaction_dates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create transaction_date" do
    assert_difference('TransactionDate.count') do
      post :create, transaction_date: { day: @transaction_date.day, month: @transaction_date.month, year: @transaction_date.year }
    end

    assert_redirected_to transaction_date_path(assigns(:transaction_date))
  end

  test "should show transaction_date" do
    get :show, id: @transaction_date
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @transaction_date
    assert_response :success
  end

  test "should update transaction_date" do
    put :update, id: @transaction_date, transaction_date: { day: @transaction_date.day, month: @transaction_date.month, year: @transaction_date.year }
    assert_redirected_to transaction_date_path(assigns(:transaction_date))
  end

  test "should destroy transaction_date" do
    assert_difference('TransactionDate.count', -1) do
      delete :destroy, id: @transaction_date
    end

    assert_redirected_to transaction_dates_path
  end
end
