ActiveAdmin.register Event do
  scope :all_events, :default => true
  scope :future
  scope :past
  scope :featured

  filter :name
  filter :date

  form :partial => 'form'

  controller do
    def new
      @event = Event.new
      @event.visible ||= true
      @event.date ||= Time.now
    end

    def show
      redirect_to admin_events_path
    end
  end

  index do
    column :name do |event|
      link_to content_tag('nobr', event), edit_admin_event_path(event)
    end

    column :price, :sortable => false
    column :date

    column :visible do |good|
      status_tag(I18n.t("active_admin.status_tags.good.#{good.status}"), good.visible? ? :ok : :error)
    end

  end

end
