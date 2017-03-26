require 'test_helper'

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
    @restaurants = Restaurant.all
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should create restaurant" do
    assert_difference('Restaurant.count') do
      post restaurants_url, params: { restaurant: { address: @restaurant.address, city: @restaurant.city, down_votes: @restaurant.down_votes, name: @restaurant.name, state: @restaurant.state, up_votes: @restaurant.up_votes, zip: @restaurant.zip } }
    end

    assert_redirected_to restaurant_url(Restaurant.last)
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should update restaurant" do
    patch restaurant_url(@restaurant), params: { restaurant: { address: @restaurant.address, city: @restaurant.city, down_votes: @restaurant.down_votes, name: @restaurant.name, state: @restaurant.state, up_votes: @restaurant.up_votes, zip: @restaurant.zip } }
    assert_redirected_to restaurant_url(@restaurant)
  end

  test "should destroy restaurant" do
    assert_difference('Restaurant.count', -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_url
  end
  
    
  test "should get searched result" do
  	# total fixtures should equal to four at start
  	assert_equal @restaurants.count, 4
  	
  	# after search they should account for two fixtures
  	# because only two have chicago as a city
  	assert_equal @restaurants.search("Chicago").count, 2
  	
  	# see if partial mixed case strings work for city as well
  	assert_equal @restaurants.search("cHiCa").count, 2
  	
  	# make sure search by integer values works for full
  	# and partial strings
  	assert_equal @restaurants.search(60614).count, 1
  	assert_equal @restaurants.search(60).count, 2
  end
  
  test "should increment vote" do 
	# Increase restaurant up_votes by one and make sure
	# that it follows to the correct page showing the 
	# specific restaurant that has been changed
	before = @restaurant.up_votes
	post up_vote_restaurant_url(@restaurant)
	assert_response :found
	follow_redirect!
	assert_response :success
	after  = @restaurant.up_votes
	assert_equal before, after
  	
  	# Increase restaurant down_votes by one and make sure
	# that it follows to the correct page showing the 
	# specific restaurant that has been changed
	before = @restaurant.down_votes
	post down_vote_restaurant_url(@restaurant)
	assert_response :found
	follow_redirect!
	assert_response :success
	after  = @restaurant.down_votes
	assert_equal before, after
  end
end
