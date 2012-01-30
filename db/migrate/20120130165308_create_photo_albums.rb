class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|
      t.string :name
      t.references :event
      t.boolean :visible

      t.timestamps
    end
    add_index :photo_albums, :event_id
  end
end
