class Attachment < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  default_scope order('position ASC')

  acts_as_list :scope => [:resource_type, :resource_id]

  has_attached_file :image, {
    :url => "/system/:hash.:extension",
    :hash_secret => "U41b45fGvpaqShAVA2LE",
    :styles => lambda { |attachment| 
      rs = attachment.instance.resource
      styles = { :thumb => "100x100#" }
      if rs.methods.include? :attachment_styles
        styles.merge! rs.attachment_styles
      end
      
      styles
    }
  }

  validates_attachment_presence :image

  before_save :set_name

protected
  def set_name
    self.name = self.image_file_name if self.name.nil?
  end
end
