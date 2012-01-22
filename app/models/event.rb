class Event < ActiveRecord::Base
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy
  scope :sorted, order('date desc')
  scope :visible, where(:visible => true)

  scope :all_events, where('1=1')
  scope :future, where('date >= current_timestamp')
  scope :past, where('date < current_timestamp')
  scope :featured, where(:featured => true)

  scope :today, where("date_trunc('day', date) = date_trunc('day', current_timestamp)").visible
  scope :on_site, visible.sorted
  scope :site_future, future.on_site
  scope :site_featured, featured.on_site

  validates :name, :presence => true, 
                   :length => { :maximum => 255 }
  validates :price, :presence => true,
                   :length => { :maximum => 255 }
  validates :date, :presence => true

  VISIBLE = "visible"
  INVISIBLE = "invisible"

  def status
    visible ? VISIBLE : INVISIBLE
  end

  def to_s
    name
  end

  def attachment_styles
    { :main_page_images => "200x240#", :main_page_images_small => "150x150#" } 
  end

end
