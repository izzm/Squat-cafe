class AddPositionToPhotoAlbums < ActiveRecord::Migration
  def change
    add_column :photo_albums, :position, :integer
  end
end
