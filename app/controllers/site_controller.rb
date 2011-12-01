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

end
