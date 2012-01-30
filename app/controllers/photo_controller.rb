class PhotoController < ApplicationController
  def index
    @photo_albums = PhotoAlbum.visible
  end
end
