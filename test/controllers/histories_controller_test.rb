require 'test_helper'

class HistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @history = histories(:one)
  end

  test "should get index" do
	# Try accessing history as regular user
	get histories_url
	assert_redirected_to restaurants_url
	
	# Try accessing history as admin
	logout
	
	login_as users(:admin), 'admin'
    get histories_url
    assert_response :success
  end

  test "should create history" do
    assert_difference('History.count') do
      post histories_url, params: { history: { 
    	down_votes_added: @history.down_votes_added, 
    	down_votes_total: @history.down_votes_total, 
    	restaurant_id: 	  @history.restaurant_id, 
    	up_votes_added:   @history.up_votes_added, 
    	up_votes_total:   @history.up_votes_total, 
    	user_id: 		  users(:three).id } }
    end

    assert_redirected_to history_url(History.last)
  end

  test "should show history" do
    # Try accessing history as regular user
    get history_url(@history)
    assert_redirected_to restaurants_url
    
    # Try accessing history as admin
	logout
	
	login_as users(:admin), 'admin'
    get history_url(@history)
    assert_response :success
  end

end
