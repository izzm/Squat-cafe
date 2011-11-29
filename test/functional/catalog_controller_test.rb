require 'test_helper'

class CatalogControllerTest < ActionController::TestCase
  test "should get category" do
    get :category
    assert_response :success
  end

  test "should get good" do
    get :good
    assert_response :success
  end

  test "should get compare" do
    get :compare
    assert_response :success
  end

  test "should get add_to_compare" do
    get :add_to_compare
    assert_response :success
  end

  test "should get remove_from_compare" do
    get :remove_from_compare
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

end
