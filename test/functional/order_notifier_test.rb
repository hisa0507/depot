require 'test_helper'

class OrderNotifierTest < ActionMailer::TestCase
  test "received" do
    mail = OrderNotifier.received(orders(:one))
    assert_equal "注文確認", mail.subject
    assert_equal ["hungry0507@hotmail.com"], mail.to
    assert_equal ["info@doublw.com"], mail.from
    assert_match /1 x mewtwo/, mail.body.encoded
  end

  test "shipped" do
    mail = OrderNotifier.shipped(orders(:one))
    assert_equal "出荷されました", mail.subject
    assert_equal ["hungry0507@hotmail.com"], mail.to
    assert_equal ["info@doublw.com"], mail.from
    assert_match /<td>1&times;<\/td>\s*<td>mewtwo<\/td>/, mail.body.encoded
  end

end
