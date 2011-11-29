class AddAttachmentImageToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :image_file_name, :string
    add_column :attachments, :image_content_type, :string
    add_column :attachments, :image_file_size, :integer
    add_column :attachments, :image_updated_at, :datetime
    add_column :attachments, :image_fingerprint, :string
  end

end
