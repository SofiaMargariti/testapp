require 'test_helper'

class AdminMailerTest < ActionMailer::TestCase
  def setup
    @vessel = Vessel.create(title: 'test vessel', description: 'vessel description', daily_price: 200)
  end

  def teardown
    @vessel.delete
  end

  test "notify vessel created" do
    email = AdminMailer.notify_vessel_created('127.0.0.1', @vessel).deliver_now
    assert_not ActionMailer::Base.deliveries.empty?
    assert_equal ['admin@example.com'], email.from
    assert_equal ['testappadm@mailinator.com'], email.to
    assert_match /.*#{@vessel.id}.*/,  email.body.to_s
    assert_match /.*#{@vessel.title}.*/,  email.body.to_s
    assert_match /.*#{@vessel.description}.*/,  email.body.to_s
  end
end
