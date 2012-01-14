class OrderMailer < ActionMailer::Base
  default from: "orders@oltis-lux.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.customer_email.subject
  #
  def customer_email(customer, order)
    @order = order

    mail :to => customer.email,
         :subject => I18n.t('customer_email.order_subject')
  end
end
