require 'test_helper'

class Admin::VesselsControllerTest < ActionController::TestCase

  def setup
    @user = User.create(name: "Example User", email: "user@example.com", password: "lalala", admin: false)
    @admin = User.create(name: "Admin User", email: "admin@example.com", password: "lalala", admin: true)
  end

  def teardown
    @user.delete
    @admin.delete
  end

  test "should forbid unauthorized access" do
    # not authenticated user 
    get :index
    assert_redirected_to login_path

    # authenticated but not an admin
    get(:index, nil, {'user_id' => @user.id})
    assert_redirected_to login_path 
  end

  test "should permit access for admin user" do
    # authenticated admin
    get :index, nil, {'user_id' => @admin.id} 
    assert_response :success
  end
end
