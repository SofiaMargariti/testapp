require 'test_helper'

class VesselsControllerTest < ActionController::TestCase
  def setup
    @user = User.create(name: 'Test User', email: 'test@test.com', admin: false, password: 'lalala')
    @admin = User.create(name: 'Test User', email: 'admin@test.com', admin: true, password: 'lalala')
  end

  def teardown
    @user.delete
    @admin.delete
  end

  test "should send email for unauthorised user" do
    # create 
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, :vessel => {title: 'test vessel', description: 'vessel description', daily_price: 200}
    end
    email = ActionMailer::Base.deliveries.last
    assert_equal ['admin@example.com'], email.from
    assert_equal ['testappadm@mailinator.com'], email.to
    assert_match /.*test vessel.*/,  email.body.to_s
    assert_equal "New vessel created", email.subject
    assert_match /.*vessel description.*/,  email.body.to_s

    # update
    @vessel = Vessel.create(title: 'test vessel', description: 'vessel description', daily_price: 200)
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :update, :id => @vessel, :vessel => {title: 'new title'}
    end
    email = ActionMailer::Base.deliveries.last
    assert_equal ['admin@example.com'], email.from
    assert_equal ['testappadm@mailinator.com'], email.to
    assert_equal "A vessel was updated", email.subject
    assert_match /.*new title.*/,  email.body.to_s
  end

  test "should send email for authorised non admin user" do
    # create 
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      post :create, {:vessel => {title: 'test vessel', description: 'vessel description', daily_price: 200}}, {'user_id' => @user.id}
    end
    email = ActionMailer::Base.deliveries.last
    assert_equal ['admin@example.com'], email.from
    assert_equal ['testappadm@mailinator.com'], email.to
    assert_match /.*test vessel.*/,  email.body.to_s
    assert_equal "New vessel created", email.subject
    assert_match /.*vessel description.*/,  email.body.to_s

    # update
    @vessel = Vessel.create(title: 'test vessel', description: 'vessel description', daily_price: 200)
    assert_difference 'ActionMailer::Base.deliveries.size', +1 do
      put :update, {:id => @vessel, :vessel => {title: 'new title'} }, {'user_id' => @user.id}
    end
    email = ActionMailer::Base.deliveries.last
    assert_equal ['admin@example.com'], email.from
    assert_equal ['testappadm@mailinator.com'], email.to
    assert_match /.*new title.*/,  email.body.to_s
  end

  test "should not send email for admin user" do
    # create 
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      post :create, {:vessel => {title: 'test vessel', description: 'vessel description', daily_price: 200}}, {'user_id' => @admin.id}
    end

    # update
    @vessel = Vessel.create(title: 'test vessel', description: 'vessel description', daily_price: 200)
    assert_no_difference 'ActionMailer::Base.deliveries.size' do
      put :update, {:id => @vessel, :vessel => {title: 'new title'} }, {'user_id' => @admin.id}
    end

  end
end
