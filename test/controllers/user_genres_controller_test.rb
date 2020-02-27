require 'test_helper'

class UserGenresControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get user_genres_create_url
    assert_response :success
  end

  test "should get destroy" do
    get user_genres_destroy_url
    assert_response :success
  end

end
