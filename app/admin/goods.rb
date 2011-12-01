ActiveAdmin.register Good do
  belongs_to :category
  filter :name

  form :partial => 'form'
  scope :sorted, :default => true

  index do
    column :name do |good|
      link_to good.name, edit_admin_category_good_path(category, good)
    end
    column :price, :sortable => false
    column :visible do |good|
      status_tag(good.visible ? 'TRUE' : 'FALSE', good.visible? ? :ok : :error)
    end

    column do |good|
      link_to 'Destroy', admin_category_good_path(category, good), :method => :delete, :confirm => t('are_you_shure')
    end
  end

  controller do
    def show
      redirect_to admin_category_goods_path
    end
  end

  sidebar :tree  do |page|
    render :partial => 'admin/categories/category_tree',
           :locals => {:current_page => category,
                       :link => :good}
  end 
end
