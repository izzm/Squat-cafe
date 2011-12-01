class ApplicationController < ActionController::Base
  protect_from_forgery
  
protected
  def set_meta(meta_object)
        ActiveRecord::Base.logger.info meta_object.to_yaml
    if !request.xhr? && meta_object
      set_meta_tags :title => meta_object.seo_title,
                    :description =>meta_object .seo_description,
                    :keywords => meta_object.seo_keywords
    end
  end
end
