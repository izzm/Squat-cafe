ActiveAdmin.register Attachment do
  actions :only => [:create, :destroy, :update]
  menu false
  
  controller do
    def create
      @attachment = Attachment.new(params[:attachment])
      
      if @attachment.save
        data = {
          :thumb => @attachment.image.url(:thumb),
          :info => render_to_string(:partial => 'preferences', :locals => {:attachment => @attachment}),
          :destroy_link => render_to_string(:partial => 'destroy_link', :locals => {:attachment => @attachment}),
          :main => @attachment.main,
          :id => @attachment.id
        }

        render :json => data, :status => 201
      else
        data = {
          :thumb => false,
          :info => 'error',
          :destroy_link => 'error',
          :main => false,
          :id => 0
        }

        render :json => data, :status => 500
      end
    end

    def update
      @attachment = Attachment.find(params[:id])

      if @attachment.update_attributes(params[:attachment])
        data = {
          :thumb => @attachment.image.url(:thumb),
          :info => render_to_string(:partial => 'preferences', :locals => {:attachment => @attachment}),
          :destroy_link => render_to_string(:partial => 'destroy_link', :locals => {:attachment => @attachment}),
          :main => @attachment.main,
          :id => @attachment.id
        }

        render :json => data, :status => 201
      else
        data = {
          :thumb => false,
          :info => 'error',
          :destroy_link => 'error',
          :main => false,
          :id => 0
        }

        render :json => data, :status => 500
      end
     
    end

    def destroy
      @attachment = Attachment.find(params[:id])
      @attachment.destroy

      render :json => {:status => :ok}
    end
  end
  
  member_action :move_higher, :method => :put do
    attachment = Attachment.find(params[:id])
    attachment.move_higher
    
    redirect_to request.referrer
  end

  member_action :move_lower, :method => :put do
    attachment = Attachment.find(params[:id])
    attachment.move_lower
    
    redirect_to request.referrer
  end
end
