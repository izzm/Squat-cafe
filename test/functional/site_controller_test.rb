require 'test_helper'

class SiteControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get static_page" do
    get :static_page
    assert_response :success
  end

end
