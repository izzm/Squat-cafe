class StaticPage < ActiveRecord::Base
  acts_as_nested_set
  acts_as_list :scope => :parent
  acts_as_breadcrumbs(:attr => :url_path, :basename => :link, :separator => "/")

  scope :visible, where(:visible => true)
  scope :sorted,  order('position ASC')
  scope :navigation, visible.where(:show_in_nav => true).sorted
  #scope :nested_set,          order('lft ASC')
  #scope :reversed_nested_set, order('lft DESC')

  #default_scope order('position asc')
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy

  validates :title, :presence => true, 
                    :length => { :maximum => 255 }
  validates :content, :presence => true 
  validates :link, :presence => true,
                   :uniqueness => {:scope => :parent_id}

  VISIBLE = "visible"
  INVISIBLE = "invisible"

  def to_s
    title
  end
  
  def attachment_styles
    { :main_page_images => "200x240#" } 
  end

  def status
    visible ? VISIBLE : INVISIBLE
  end

  def show_in_nav_status
    show_in_nav ? VISIBLE : INVISIBLE
  end

  def show_in_nav?
    visible && super
  end
  
  def use_absolute_path?
    !redirect_url.blank?
  end

end
