ActiveAdmin.register StaticPage do
  filter :title
  scope :roots, :default => :true

  form :partial => 'form'

  controller do
    def index
      redirect_to index_tree_admin_static_pages_path
    end
    
    def show
      #redirect_to edit_admin_static_page_path(@page)
      redirect_to index_tree_admin_static_pages_path
    end
  end

  collection_action :index_tree, :method => :get do
    @static_pages = StaticPage.arrange

    render :action => 'blank' if @static_pages.blank?
  end
  
  sidebar :tree, :only => [:edit]  do |page|
    render :partial => 'page_tree',
           :locals => {:current_page => static_page,
                       :link => :edit}
  end 
end
