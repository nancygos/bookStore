require "test_helper"

class Api::V1::CartsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_carts_index_url
    assert_response :success
  end

  test "should get new" do
    get api_v1_carts_new_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_carts_show_url
    assert_response :success
  end

  test "should get edit" do
    get api_v1_carts_edit_url
    assert_response :success
  end
end
