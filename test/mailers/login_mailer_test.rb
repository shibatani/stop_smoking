require 'test_helper'

class LoginMailerTest < ActionMailer::TestCase
  test "send_when_not_login" do
    mail = LoginMailer.send_when_not_login
    assert_equal "Send when not login", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
