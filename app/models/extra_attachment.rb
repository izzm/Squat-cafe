class ExtraAttachment < ActiveRecord::Base
  belongs_to :resource, :polymorphic => true
  default_scope order('position ASC')

  acts_as_list :scope => [:resource_type, :resource_id]

  has_attached_file :file, {
    :url => "/files/:hash.:extension",
    :hash_secret => "f6Y8Yq2QWCIBiYnexSH9",
    :styles => { :color => "50x42#" }
  }

  validates_attachment_presence :file

#  before_save :set_name

protected
  def set_name
    self.name = self.file_file_name if self.name.nil?
  end

end
