require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  test "customer_email" do
    mail = OrderMailer.customer_email
    assert_equal "Customer email", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
