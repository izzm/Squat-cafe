class Event < ActiveRecord::Base
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy
  has_many :photo_albums,
           :dependent => :nullify
  scope :sorted, order('date desc')
  scope :inv_sorted, order('date asc')
  scope :visible, where(:visible => true)

  scope :all_events, where('1=1')
  scope :future, where('date >= current_timestamp')
  scope :past, where('date < current_timestamp')
  scope :featured, where(:featured => true)

  scope :today, where("date_trunc('day', date) = date_trunc('day', current_timestamp)").visible
  scope :of_current_year, where("extract(year from date) = extract(year from current_timestamp)")
  scope :for_calendar, select("max(name) as name, date_trunc('day', date) as date").group("date_trunc('day', date)")

  scope :on_site, visible.sorted
  scope :site_future, future.visible.inv_sorted
  scope :site_featured, featured.on_site
  
  scope :by_year_and_month, lambda { |year, month|
    events_date = Date.new(year.to_i, month.to_i) rescue Date.today
    
    where(["date_trunc('month', date) = date_trunc('month', TIMESTAMP ?)", events_date])
  }

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

  def date_json
    [date.month, date.day, date.year]
  end
  
  def self.months
    Event.on_site.select("DISTINCT date_trunc('month', date) as date").collect(&:date).sort
  end

  def attachment_styles
    { :main_page_images => "200x240#", :main_page_images_small => "150x150#", :event => "250" } 
  end

end
