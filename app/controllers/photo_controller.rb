class PhotoController < ApplicationController
  def index
    @photo_albums = PhotoAlbum.visible.sorted.page(params[:page]).per(5)
  end
  
  def album
    @photo_album = PhotoAlbum.visible.find_by_id(params[:id])
    
    redirect_to photo_url if @photo_album.nil?
  end
  
  def single
    @attachment = Attachment.find_by_id(params[:id])
    
    if @attachment.nil? || @attachment.resource_type != "PhotoAlbum" || !@attachment.resource.visible
      redirect_to photo_url
    end
  end
end
