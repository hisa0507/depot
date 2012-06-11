require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products
  
 test "buying a product"
  LineItem.delete_all
  Order.delete_all
  mewtwo = products(:mewtwo)
  
  get "/"
  assert_response :success
  assert_template "index"
  
  xml_http_request :post, '/line_items', product_id: mewtwo.id
  assert_response :success
  
  cart = Cart.find(session[:cart_id])
  assert_equal 1, cart.line_items.size
  assert_equal mewtwo, cart.line_items[0].product
  
  get "/orders/new"
  assert_response :success
  assert_template "new"
  
  post_via_redirect "/orders",
                    order: { name: "Son Masayoshi",
                             address: "softbank",
                             email: "son@softbank.jp",
                             pay_type: "銀行振込" }
  assert_response :success
  assert_template "index"
  cart = Cart.find(session[:cart_id])
  assert_equal 0, cart.line_items.size
  
  orders = Order.all
  assert_equal 1, order.line_items.size
  line_item = order.line_items[0]
  assert_equal mewtwo, line_item.product
  
  mail = ActionMailer::Base.deliveries.last
  assert_equal ["son@softbank.jp"], mail.to
  assert_equal 'mewtwo <info@doublw.com>', mail[:from] .value
  assert_equal "注文確認", mail.subject
  
  # test "the truth" do
  #   assert true
 end
end
