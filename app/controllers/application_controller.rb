class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :init_cart
  before_filter :init_compare
#  before_filter :set_locale
  
protected
  def set_meta(meta_object)
    if !request.xhr? && meta_object
      set_meta_tags :title => meta_object.seo_title,
                    :description =>meta_object .seo_description,
                    :keywords => meta_object.seo_keywords
    end
  end

  def set_locale(locale)
    I18n.locale = locale
  end

  def init_cart
    session[:cart] ||= {}
    session[:cart_count] ||= 0
    session[:cart_price] ||= 0
  end
  
  def init_compare
    session[:compare] ||= {}
  end
end
