ActiveAdmin.register Good do
  belongs_to :category
  filter :name, :label => I18n.t('active_admin.filters.good.name')
  filter :articul

  form :partial => 'form'
  #scope :sorted, :default => true

  index do
    column :name do |good|
      link_to good.name, edit_admin_category_good_path(category, good)
    end
    column :articul, :sortable => false
    column :price, :sortable => false
    column :visible do |good|
      status_tag(I18n.t("active_admin.status_tags.good.#{good.status}"), good.visible? ? :ok : :error)
    end

    column do |good|
      link_to I18n.t('active_admin.actions.good.destroy'), admin_category_good_path(category, good), :method => :delete, :confirm => t('are_you_shure')
    end
  end

  controller do
    def new
      @category = Category.find(params[:category_id])
      @good = @category.goods.build
      @good.visible ||= true
    end

    def show
      redirect_to admin_category_goods_path
    end
  end

  sidebar I18n.t('active_admin.titles.good.tree') do |page|
    render :partial => 'admin/categories/category_tree',
           :locals => {:current_page => category,
                       :link => :good}
  end 
end
