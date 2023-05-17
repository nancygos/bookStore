require "test_helper"

class Api::V1::BooksControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_books_index_url
    assert_response :success
  end

  test "should get new" do
    get api_v1_books_new_url
    assert_response :success
  end

  test "should get edit" do
    get api_v1_books_edit_url
    assert_response :success
  end

  test "should get show" do
    get api_v1_books_show_url
    assert_response :success
  end
end
