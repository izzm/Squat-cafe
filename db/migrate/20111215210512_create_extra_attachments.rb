class CreateExtraAttachments < ActiveRecord::Migration
  def change
    create_table :extra_attachments do |t|
      t.references :resource, :polymorphic => true, :null => false

      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
