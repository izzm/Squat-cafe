ActiveAdmin.register PhotoAlbum, {:sort_order => 'position_asc'} do
  filter :name
  filter :created_at
  
  form :partial => 'form'

  controller do
    def new
      @photo_album = PhotoAlbum.new
      @photo_album.visible ||= true
    end

    def show
      @photo_album = PhotoAlbum.find(params[:id])

      redirect_to edit_admin_photo_album_path(@photo_album)
    end
  end

  index do
    column :name do |photo_album|
      link_to photo_album, edit_admin_photo_album_path(photo_album)
    end
    
    column "" do |photo_album|
      acc = ""
      
      acc += photo_album.first? ? 
            image_tag('arrow_up_notactive.png') :  
            link_to(image_tag('arrow_up.png'), 
              move_higher_admin_photo_album_path(photo_album), 
              :method => :put)
      acc += photo_album.last? ?
            image_tag('arrow_down_notactive.png') :
            link_to(image_tag('arrow_down.png'), 
              move_lower_admin_photo_album_path(photo_album), 
              :method => :put)
      raw content_tag :div, raw(acc), :style => 'width: 50px;'
    end

    column :visible do |photo_album|
      status_tag(I18n.t("active_admin.status_tags.photo_album.#{photo_album.status}"), photo_album.visible? ? :ok : :error)
    end

    column :created_at
    column :photo_count do |photo_album|
      photo_album.attachments.count.to_s
    end

    column "" do |photo_album|
      link_to t('active_admin.actions.photo_album.destroy'), admin_photo_album_path(photo_album), :method => :delete, :confirm => t('are_you_shure') 
    end
  end
  
  member_action :move_higher, :method => :put do
    photo_album = PhotoAlbum.find(params[:id])
    photo_album.move_higher
    
    redirect_to admin_photo_albums_path
  end

  member_action :move_lower, :method => :put do
    photo_album = PhotoAlbum.find(params[:id])
    photo_album.move_lower
    
    redirect_to admin_photo_albums_path
  end
  
end
