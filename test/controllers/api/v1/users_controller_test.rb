require 'test_helper'

class Api::V1::UsersControllerTest < ActionDispatch::IntegrationTest
  :IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should show user" do
    get api_v1_user_url(@user), as: :json
    assert_response :success
    # Test to ensure response contains the correct email
    json_response = JSON.parse(self.response.body)
    assert_equal @user.email, json_response['email']
  end

  #Test to check creation of a user by sending a valid POST request. Then, we check that the additional
  #user exists in the database and the HTTP code response is created (201)
  test "should create user" do
    assert_difference('User.count') do
      post api_v1_users_url, params: { user: { email: 'test@test.org', password: '123456' } }, as: :json
    end
    assert_response :created
  end

  #Test to check that the user is not created using that email already. Then, we check that the code of
  #response is unprocessable_entity (422)
  test "should not create user with taken email" do
    assert_no_difference('User.count') do
      post api_v1_users_url, params: { user: { email: @user.email, password: '123456' } }, as: :json
    end
    assert_response :unprocessable_entity
  end

  # Test for updating users. This respond to PUT/PATCH requests. Only connected users
  # should be able to update his information.

  test "should update user" do
    patch api_v1_user_url(@user), params: { user: { email: @user.email, password: '123456' } }, as: :json
    assert_response :success
  end


  test "should not update user when invalid params are sent" do
    patch api_v1_user_url(@user), params: { user: { email: 'bad_email', password: '123456' } }, as: :json
    assert_response :unprocessable_entity  
  end 

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete api_v1_user_url(@user), as: :json
    end
    assert_response :no_content
  end
    
end
