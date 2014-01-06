require 'test_helper'

class BitcoinPricesControllerTest < ActionController::TestCase
  setup do
    @bitcoin_price = bitcoin_prices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bitcoin_prices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bitcoin_price" do
    assert_difference('BitcoinPrice.count') do
      post :create, bitcoin_price: {  }
    end

    assert_redirected_to bitcoin_price_path(assigns(:bitcoin_price))
  end

  test "should show bitcoin_price" do
    get :show, id: @bitcoin_price
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bitcoin_price
    assert_response :success
  end

  test "should update bitcoin_price" do
    patch :update, id: @bitcoin_price, bitcoin_price: {  }
    assert_redirected_to bitcoin_price_path(assigns(:bitcoin_price))
  end

  test "should destroy bitcoin_price" do
    assert_difference('BitcoinPrice.count', -1) do
      delete :destroy, id: @bitcoin_price
    end

    assert_redirected_to bitcoin_prices_path
  end
end
