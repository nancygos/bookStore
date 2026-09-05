require "test_helper"

class Api::V1::ShortUrlsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get "/api/v1/short_urls"
    assert_response :success
  end

  test "should create a short url" do
    assert_difference("ShortUrl.count", 1) do
      post "/api/v1/short_urls", params: { long_url: "https://example.com/book" }
    end
    assert_response :created
  end

  test "should redirect a valid short code" do
    short_url = short_urls(:one)
    short_url.update!(expires_at: 1.day.from_now, long_url: "https://example.com")

    get "/api/v1/nancy/#{short_url.short_code}"
    assert_response :redirect
  end
end
