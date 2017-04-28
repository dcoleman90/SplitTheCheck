require 'test_helper'

class HistoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @history = histories(:one)
    @restaurant = restaurants(:one)
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
  
  test "should add up vote" do
  	# Check last entry in history
	old_history       = History.last
	old_up_vote_added = old_history.up_votes_added
	old_votes_total   = old_history.up_votes_total

	# User clicks up vote icon, final redirect back to 
	# restaurant page.
	get up_vote_restaurant_url(@restaurant)
	follow_redirect!
	assert_redirected_to restaurant_url(@restaurant)
	
	# Check new recently added history due to up_vote
	new_history       = History.last
	new_up_vote_added = new_history.up_votes_added
	new_votes_total   = new_history.up_votes_total
	assert_equal 1, new_up_vote_added
	assert_equal new_votes_total, old_votes_total + 1
  end
  
   test "should add down vote" do
  	# Check last entry in history
	old_history         = History.last
	old_down_vote_added = old_history.down_votes_added
	old_votes_total     = old_history.down_votes_total

	# User clicks up vote icon, final redirect back to 
	# restaurant page.
	get down_vote_restaurant_url(@restaurant)
	follow_redirect!
	assert_redirected_to restaurant_url(@restaurant)
	
	# Check new recently added history due to up_vote
	new_history         = History.last
	new_down_vote_added = new_history.down_votes_added
	new_votes_total     = new_history.down_votes_total
	assert_equal 1, new_down_vote_added
	assert_equal new_votes_total, old_votes_total + 1
  end

end
