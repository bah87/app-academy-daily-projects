require 'test_helper'

class VotesControllerTest < ActionDispatch::IntegrationTest
  test "should get update" do
    get votes_update_url
    assert_response :success
  end

end
