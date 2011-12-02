class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :init_cart
  
protected
  def set_meta(meta_object)
        ActiveRecord::Base.logger.info meta_object.to_yaml
    if !request.xhr? && meta_object
      set_meta_tags :title => meta_object.seo_title,
                    :description =>meta_object .seo_description,
                    :keywords => meta_object.seo_keywords
    end
  end
  
  def init_cart
    session[:cart] ||= {}
    session[:cart_count] ||= 0
    session[:cart_price] ||= 0
  end
end
