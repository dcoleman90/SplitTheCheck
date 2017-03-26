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
end
