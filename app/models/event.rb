class Event < ActiveRecord::Base
  has_many :attachments, 
           :as => :resource,
           :dependent => :destroy
  
  scope :all_events, where('1=1')
  scope :future, where('date >= current_timestamp')
  scope :past, where('date < current_timestamp')
  scope :featured, where(:featured => true)

  validates :name, :presence => true, 
                   :length => { :maximum => 255 }
  validates :price, :presence => true,
                    :numericality => true 
  validates :date, :presence => true

  VISIBLE = "visible"
  INVISIBLE = "invisible"

  def status
    self.visible ? VISIBLE : INVISIBLE
  end

  def to_s
    self.name
  end


end
