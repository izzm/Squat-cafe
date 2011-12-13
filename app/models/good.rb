class Good < ActiveRecord::Base
  acts_as_list :scope => :category

  serialize :parameters
  serialize :variants

  belongs_to :category
  has_and_belongs_to_many :virtual_categories, :class_name => 'Category'
  
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy
  has_many :order_goods,
           :dependent => :restrict

  default_scope order('position ASC')
  scope :visible, where(:visible => true)
  scope :random, lambda { |cnt|
    order('random()').limit(cnt)
  }
  scope :not, lambda { |id|
    where(['id <> ?', id])
  }         
  
  validates :name, :presence => true, 
                   :length => { :maximum => 255 }
  validates :price, :presence => true,
                    :numericality => true 
  
  VISIBLE = "visible"
  INVISIBLE = "invisible"

  def variants
    {
      "color" => [],
      "cloth" => [],
      "size" => []
    }.merge(super || {})
  end

  def nested_parameters
	  (self.parameters.nil? && !self.category.nil?) ? 
	      self.category.nested_parameters : self.parameters
	end

  def to_s
    self.title
  end

  def present_in?(category)
    return ( category.virtual && self.virtual_category_ids.include?(category.id) ) || 
    ( !category.virtual && self.category_id == category.id )
  end
  
  def attachment_styles
    { :preview => "219x134#", :big => "350x245#", :small => "66x66#", :cart => "101x80", :compare => "184x111#" } 
  end

  def status
    self.visible ? VISIBLE : INVISIBLE
  end

end
