require 'test_helper'

class MessengerControllerTest < ActionController::TestCase
  test "should get validate" do
    get :validate
    assert_response :success
  end

  test "should get conversation" do
    get :conversation
    assert_response :success
  end

  test "should get allocator" do
    get :allocator
    assert_response :success
  end

end
