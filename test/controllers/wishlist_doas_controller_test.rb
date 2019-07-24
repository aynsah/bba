require 'test_helper'

class WishlistDoasControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get wishlist_doas_index_url
    assert_response :success
  end

  test "should get show" do
    get wishlist_doas_show_url
    assert_response :success
  end

  test "should get new" do
    get wishlist_doas_new_url
    assert_response :success
  end

  test "should get edit" do
    get wishlist_doas_edit_url
    assert_response :success
  end

end
