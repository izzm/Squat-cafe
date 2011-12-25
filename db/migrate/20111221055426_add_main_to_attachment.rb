class AddMainToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :main, :boolean, :default => false
  end
end
