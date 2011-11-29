ActiveAdmin.register Category do
  menu :parent => 'Site content'
  form :partial => 'form'

  controller do
    def index
      redirect_to index_tree_admin_categories_path
    end
    
    def show
      redirect_to index_tree_admin_categories_path
    end
  end

  collection_action :index_tree, :method => :get do
    @categories = Category.arrange

    render :action => 'blank' if @categories.blank?
  end
  
  sidebar :tree, :only => [:edit]  do |page|
    render :partial => 'category_tree',
           :locals => {:current_page => category,
                       :link => :edit}
  end 
 
end
