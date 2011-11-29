class StaticPage < ActiveRecord::Base
  acts_as_nested_set
  acts_as_list :scope => :parent
  acts_as_breadcrumbs(:attr => :url_path, :basename => :link, :separator => "/")

  scope :visible, where(:visible => true)
  scope :sorted,  order('position ASC')
  scope :nested_set,          order('lft ASC')
  scope :reversed_nested_set, order('lft DESC')

  #default_scope order('position asc')
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy

  validates :title, :presence => true, 
                    :length => { :maximum => 255 }
  validates :content, :presence => true 
  validates :link, :presence => true,
                   :uniqueness => {:scope => :parent_id}

  def to_s
    self.title
  end

end
