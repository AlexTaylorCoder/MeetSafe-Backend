require "test_helper"

class ExchangesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exchange = exchanges(:one)
  end

  test "should get index" do
    get exchanges_url, as: :json
    assert_response :success
  end

  test "should create exchange" do
    assert_difference("Exchange.count") do
      post exchanges_url, params: { exchange: { address_1: @exchange.address_1, address_1_lat: @exchange.address_1_lat, address_1_lng: @exchange.address_1_lng, address_2: @exchange.address_2, address_2_lat: @exchange.address_2_lat, address_2_lng: @exchange.address_2_lng, invite_code: @exchange.invite_code, meeting_address: @exchange.meeting_address, meeting_address_lat: @exchange.meeting_address_lat, meeting_address_lng: @exchange.meeting_address_lng, meettime: @exchange.meettime } }, as: :json
    end

    assert_response :created
  end

  test "should show exchange" do
    get exchange_url(@exchange), as: :json
    assert_response :success
  end

  test "should update exchange" do
    patch exchange_url(@exchange), params: { exchange: { address_1: @exchange.address_1, address_1_lat: @exchange.address_1_lat, address_1_lng: @exchange.address_1_lng, address_2: @exchange.address_2, address_2_lat: @exchange.address_2_lat, address_2_lng: @exchange.address_2_lng, invite_code: @exchange.invite_code, meeting_address: @exchange.meeting_address, meeting_address_lat: @exchange.meeting_address_lat, meeting_address_lng: @exchange.meeting_address_lng, meettime: @exchange.meettime } }, as: :json
    assert_response :success
  end

  test "should destroy exchange" do
    assert_difference("Exchange.count", -1) do
      delete exchange_url(@exchange), as: :json
    end

    assert_response :no_content
  end
end
