require 'test_helper'

class CampaignComplaintsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get campaign_complaints_new_url
    assert_response :success
  end

end
