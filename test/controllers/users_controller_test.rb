require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get index" do
    # Test as regular user
    get users_url
    assert_redirected_to restaurants_url
    
    # Test as admin
    logout
    login_as users(:admin), 'admin'
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { 
      email: 	'sam@example.com', 
      name: 	'Sam', 
      password: 'secret', 
      password_confirmation: 'secret' } }
    end

    assert_redirected_to restaurants_url
  end

  test "should show user" do
    # Test as regular user
    get user_url(@user)
    assert_redirected_to restaurants_url
    
    # Test as admin
    logout
    login_as users(:admin), 'admin'
    get user_url(@user)
    assert_response :success
  end

  test "should get edit" do
    # Test as regular user
    get edit_user_url(@user)
    assert_redirected_to restaurants_url
    
    # Test as admin
    logout
    login_as users(:admin), 'admin'
    get edit_user_url(@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url(@user), params: { user: { 
    email: 	  @user.email, 
    name: 	  @user.name, 
    password: 'secret', 
    password_confirmation: 'secret' } }
    assert_redirected_to admin_url
  end

end
