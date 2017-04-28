require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @comment = comments(:one)
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    # Try accessing comments table as regular user
    get comments_url
    assert_redirected_to restaurants_url

	# Try accessing comments table as admin    
    logout 
	login_as users(:admin), 'admin'
	get comments_url
	assert_response :success
  end

  test "should get new" do
    get new_comment_path(:comment => 
    	{:restaurant_id  => @restaurant.id} )
    	
    assert_response :success
  end

  test "should create comment" do
    assert_difference('Comment.count') do
      post comments_url, params: { comment: { 
      	comment:       @comment.comment, 
      	restaurant_id: @comment.restaurant_id, 
      	user_id:       @comment.user_id } }
    end

    assert_redirected_to restaurant_url(@comment.restaurant_id)
  end

  test "should show comment" do
    get comment_url(@comment)
    assert_response :success
  end

  test "should get edit" do
    get edit_comment_url(@comment)
    assert_response :success
  end

  test "should update comment" do
    patch comment_url(@comment), params: { comment: { 
    	comment:       @comment.comment, 
    	restaurant_id: @comment.restaurant_id, 
    	user_id: @comment.user_id } }
    	
    assert_redirected_to comment_url(@comment)
  end

  test "should destroy comment" do
    assert_difference('Comment.count', -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to comments_url
  end
end
