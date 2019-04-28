require 'test_helper'

class YoutubeListControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get youtube_list_index_url
    assert_response :success
  end

end
