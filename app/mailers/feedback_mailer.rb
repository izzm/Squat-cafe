class FeedbackMailer < ActionMailer::Base
  default from: "feedback@oltis-lux.com"

  def customer_email(data = {})
    @data = data

    mail :to => data[:email],
         :subject => I18n.t('customer_email.subject')
  end

  def admin_email(data = {})
    @data = data
    
    #AdminUser.all.map(&:email)
    mail :to => "vladislav.izoria@gmail.com",
         :subject => I18n.t('admin_email.subject')
  end
end
