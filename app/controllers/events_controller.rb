class EventsController < ApplicationController
  def index
    @events = Event.on_site
    @current_event = Event.find_by_id(flash[:current_event_id])
  end

  def bydate
    @current_event = Event.on_site.where(["date_trunc('day', date) = ?", params[:date].to_date]).first
    
    flash[:current_event_id] = @current_event.id
  end
  
  def bydate_and_id
    @current_event = Event.on_site.where(["date_trunc('day', date) = ?", params[:date].to_date]).where(:id => params[:id].to_i).first
    
    flash[:current_event_id] = @current_event.id
    render :action => 'bydate'
  end
end
