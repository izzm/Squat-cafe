require 'test_helper'

class CartControllerTest < ActionController::TestCase
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

  test "should get recalculate" do
    get :recalculate
    assert_response :success
  end

  test "should get purchase" do
    get :purchase
    assert_response :success
  end

end
