class EventsController < ApplicationController
  def index
    @events = Event.on_site
    @current_event = Event.find_by_id(flash[:current_event_id])
  end

  def bydate
    flash[:current_event_id] = Event.on_site.where(["date_trunc('day', date) = ?", params[:date].to_date]).first.id
    redirect_to events_url(:anchor => params[:date])
  end
end
