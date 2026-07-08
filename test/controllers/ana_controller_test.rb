require "test_helper"

class AnaControllerTest < ActionDispatch::IntegrationTest
  test "should get sayfa" do
    get ana_sayfa_url
    assert_response :success
  end
end
