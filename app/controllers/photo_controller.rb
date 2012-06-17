class PhotoController < ApplicationController
  def index
    @photo_albums = PhotoAlbum.visible
  end
  
  def single
    @attachment = Attachment.find_by_id(params[:id])
    
    if @attachment.nil? || @attachment.resource_type != "PhotoAlbum" || !@attachment.resource.visible
      redirect_to photo_url
    end
  end
end
