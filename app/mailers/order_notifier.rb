# coding: utf-8
class OrderNotifier < ActionMailer::Base
  default from: "Hisaaki Hangai <info@doublw.com>"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.received.subject
  #
  def received(order)
    @order = order

    mail to: order.email, subject: 'ポケモンカードストア　ご注文内容確認'
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_notifier.shipped.subject
  #
  def shipped
    @order = order

    mail to: order.email, subject: 'ご注文の商品は出荷されました。'
  end
end
