require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
  	@jake = users(:one)
  end
  
  test "should prompt for login" do
    get login_url
    assert_response :success
  end

  test "should login" do
    post login_url, params: {
    	email: @jake.email, 
    	password: 'secret'
    }
    assert_redirected_to admin_url
    assert_equal @jake.id, session[:user_id]
  end

  test "should fail login" do
	post login_url, params: {
    	email: @jake.email, 
    	password: 'wrong password'
    } 
    assert_redirected_to login_url
  end
  
  test "should logout" do
  	delete logout_url
  	assert_redirected_to restaurants_url
  end

end
