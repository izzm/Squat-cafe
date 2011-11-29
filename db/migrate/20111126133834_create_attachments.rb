class CreateAttachments < ActiveRecord::Migration
  def change
    create_table :attachments do |t|
      t.references :resource, :polymorphic => true, :null => false

      t.string :name
      t.string :link

      t.integer :position

      t.timestamps
    end
  end
end
