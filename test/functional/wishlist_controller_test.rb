require 'test_helper'

class WishlistControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get add_good" do
    get :add_good
    assert_response :success
  end

  test "should get remove_good" do
    get :remove_good
    assert_response :success
  end

end
