class PhotoAlbum < ActiveRecord::Base
  belongs_to :event
  
  acts_as_list

  scope :visible, where(:visible => true)
  scope :sorted,  order('position ASC')
  
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy

  validates :name, :presence => true, 
                    :length => { :maximum => 255 }

  VISIBLE = "visible"
  INVISIBLE = "invisible"

  def to_s
    name
  end

  def status
    visible ? VISIBLE : INVISIBLE
  end

  def attachment_styles
    { :site => "100x100#" } 
  end


end
