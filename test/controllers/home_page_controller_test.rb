require 'test_helper'

class HomePageControllerTest < ActionDispatch::IntegrationTest
  test "should get homepage" do
    get home_page_homepage_url
    assert_response :success
  end

end
