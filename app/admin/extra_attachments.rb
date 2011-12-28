ActiveAdmin.register ExtraAttachment do
  actions :only => [:create, :destroy]
  menu false
  
  controller do
    def create
      @attachment = ExtraAttachment.new(params[:extra_attachment])
      
      if @attachment.save
        data = {
          :url => @attachment.file.url(:color),
          :id => @attachment.id,
          :destroy_url => admin_extra_attachment_path(@attachment.id),
          :update_url => admin_extra_attachment_path(@attachment.id)
        }

        render :json => data, :status => 201
      else
        data = {
          :url => false,
          :id => false
        }

        render :json => data, :status => 500
      end
    end

    def update
      @attachment = ExtraAttachment.find(params[:id])

      if @attachment.update_attributes(params[:extra_attachment])
        data = {
          :url => @attachment.file.url(:color),
          :id => @attachment.id,
          :destroy_url => admin_extra_attachment_path(@attachment.id),
          :update_url => admin_extra_attachment_path(@attachment.id)
        }

        render :json => data, :status => 201
      else
        data = {
          :url => false,
          :id => false
        }

        render :json => data, :status => 500

      end
    end

    def destroy
      @attachment = ExtraAttachment.find(params[:id])
      @attachment.destroy

      render :json => {:status => :ok}
    end
  end
end
