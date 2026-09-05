require "test_helper"

class ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get short_urls_index_url
    assert_response :success
  end

  test "should get create" do
    get short_urls_create_url
    assert_response :success
  end

  test "should get show" do
    get short_urls_show_url
    assert_response :success
  end
end
