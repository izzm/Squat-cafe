class SiteController < ApplicationController
  def index
    @page = StaticPage.root
    set_meta(@page)
  end

  def static_page
    @page = StaticPage.find(params[:page_id])
    set_meta(@page)
    
    begin
      render :action => @page.link
    rescue ActionView::MissingTemplate => e
      logger.info "Use default StaticPage template"
    end
  end

  def feedback
    data = params[:feedback]
    if data[:email].blank?
      flash[:error] = I18n.t('customer_email.not_email_present')
    else
      begin
        Feedback.customer_email(data).deliver
        Feedback.admin_email(data).deliver
  
        flash[:notice] = I18n.t("customer_email.delivery_success.#{data[:callback] ? 'callback' : 'email'}")
      rescue Exception => e
        flash[:error] = I18n.t('customer_email.delivery_error')

      end
    end

    redirect_to request.referrer
  end

end
