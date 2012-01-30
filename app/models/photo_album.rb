class PhotoAlbum < ActiveRecord::Base
  belongs_to :event

  scope :visible, where(:visible => true)
  default_scope order('created_at desc')
  
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
